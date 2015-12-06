//
//  HNMySettingController.h
//  RedPacket
//
//  Created by 林 李 on 15/5/29.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNTableViewController.h"
typedef NS_ENUM(NSInteger, HNSettingSelection){
    HNSettingSelectionMyProfile,//我的祝福
    HNSettingSelectionResetPassWord,//我的亲友
    HNSettingSelectionAppInfomation,//我发出的祝福
    HNSettingSelectionVersionInfomation,
};
@interface HNMySettingController : HNTableViewController

@end
