//
//  HNFileManager.m
//  huinongbao
//
//  Created by 林 李 on 15/4/14.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//
//http://blog.csdn.net/majiakun1/article/details/38140359
#import "HNFileManager.h"
#ifdef education
#import "UserArea.h"

#elif EducationPlus

#else

#endif

#define kHNInvoiceList         @"kHNInvoiceList.plist"
#define kHNConfigureList         @"kHNConfigureList.plist"
@implementation HNFileManager
+(instancetype)defaultManager {
    static HNFileManager *_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[HNFileManager alloc] init];
    });
    return _defaultManager;
}

-(NSString*)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(NSString *)dbPath{
    return [[self documentPath] stringByAppendingPathComponent:@"huinongbao.sqlite"];
}

#import "HNFileManager.h"
-(void)setConfigureValue:(NSString*)value andKey:(NSString*)key{
    NSString *filePath = [[self documentPath] stringByAppendingPathComponent:kHNConfigureList];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]) {
        NSMutableDictionary* configure = [@{key:value} mutableCopy];
        [configure writeToFile:filePath atomically:YES];
    }else {
        NSMutableDictionary *configure = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        [configure setObject:value forKey:key];
        [configure writeToFile:filePath atomically:YES];
    }
}

-(NSString*)configureValueWithKey:(NSString*)key{
    NSString *filePath = [[self documentPath] stringByAppendingPathComponent:kHNConfigureList];
    NSMutableDictionary *configure = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    return [configure objectForKey:key];
}

#ifdef education
-(void)setUserArea:(UserArea*)userarea{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:userarea]  forKey:@"UserArea"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(UserArea*)userArea{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserArea"];
    id  user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([user isKindOfClass:[UserArea class]]) {
        return user;
    }
    return nil;
}


-(void)setCurrentAreaDetail:(AreaDetail*)areaDetail{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:areaDetail]  forKey:@"areaDetail"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(AreaDetail*)currentAreaDetail{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"areaDetail"];
    id  areainfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([areainfo isKindOfClass:[AreaDetail class]]) {
        return areainfo;
    }
    return nil;
}

-(void)umengUnregistPush{
    [UMessage removeAllTags:^(id responseObject, NSInteger remain, NSError *error) {
        if (error != nil) {
            if (error.code == kUMessageErrorDependsErr) {
                NSLog(@"获取 token失败 可能用户没有正确的获取到token");
            }else{
                NSLog(@"%@", error.localizedDescription);
            }
        }
    }];
    
    [UMessage removeAlias:[[SEUtils getUserInfo] userID] type:@"kUMessageAliasTypeWufang" response:^(id responseObject, NSError *error) {
        
    }];
}

-(void)handleLogoutEvent{
    //还可以优化
    [self umengUnregistPush];
    [SEUtils setUserInfo:nil];
    [[HNFileManager defaultManager] setUserArea:nil];
    [[HNFileManager defaultManager] setCurrentAreaDetail:nil];
    [[WFRequestManager sharedInstance] cancelAllRequest];
    [[HNHttpResponceCache sharedCache] clearCacheOnDisk];
}

-(NSMutableArray*)invoicesList{
    NSString *filePath = [[self documentPath] stringByAppendingPathComponent:kHNInvoiceList];
    NSArray* archiveInvoices =  [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray* invoicesList = [NSMutableArray array];
    for (NSData* acchivedata in archiveInvoices) {
        id  invoice = [NSKeyedUnarchiver unarchiveObjectWithData:acchivedata];
        NSLog(@"%@",[invoice class]);
        [invoicesList addObject:invoice];
    }
    return invoicesList;
}

//发票抬头
-(void)addInVoice:(HNInvoice*)invoice{
    NSString *filePath = [[self documentPath] stringByAppendingPathComponent:kHNInvoiceList];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]) {
        NSMutableArray *array = [NSMutableArray arrayWithObject:[NSKeyedArchiver archivedDataWithRootObject:invoice]];
        [array writeToFile:filePath atomically:YES];
    }else {
        NSMutableArray *array = [[NSArray arrayWithContentsOfFile:filePath] mutableCopy];
        if(![array containsObject:invoice]) {
            [array addObject:[NSKeyedArchiver archivedDataWithRootObject:invoice]];
            [array writeToFile:filePath atomically:YES];
        }
    }
}

-(void)setDeviceToken:(NSString*)token{
    [self setConfigureValue:token andKey:@"deviceToken"];
}

-(NSString*)deviceToken{
    return [self configureValueWithKey:@"deviceToken"];
}
#elif EducationPlus

#else

#endif


@end
