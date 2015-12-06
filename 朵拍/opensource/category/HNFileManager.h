//
//  HNFileManager.h
//  huinongbao
//
//  Created by 林 李 on 15/4/14.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GestureTool_Public.h"
@class User;
#ifdef education
@class UserArea;
@class AreaDetail;
@class HNInvoice;
#elif EducationPlus

#else

#endif

@interface HNFileManager : NSObject
+(instancetype)defaultManager;

-(NSString *)dbPath;//数据库文件的路径

-(void)setConfigureValue:(NSString*)value andKey:(NSString*)key;

-(NSString*)configureValueWithKey:(NSString*)key;

#ifdef education

-(void)setDeviceToken:(NSString*)token;

-(NSString*)deviceToken;
    
-(void)setUserArea:(UserArea*)userarea;

-(UserArea*)userArea;

-(void)setCurrentAreaDetail:(AreaDetail*)userarea;

-(AreaDetail*)currentAreaDetail;

//处理注销登录的事件
-(void)handleLogoutEvent;

-(void)addInVoice:(HNInvoice*)invoice;

-(NSMutableArray*)invoicesList;
#elif EducationPlus

#else

#endif
@end
