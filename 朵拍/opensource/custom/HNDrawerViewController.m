//
//  HNDrawerViewController.m
//  RedPacket
//
//  Created by 林 李 on 15/5/28.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNDrawerViewController.h"

@interface HNDrawerViewController ()

@end

@implementation HNDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(contentSizeDidChangeNotification:)
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)contentSizeDidChangeNotification:(NSNotification*)notification{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

-(void)contentSizeDidChange:(NSString *)size{
    //Implement in subclass
}

@end
