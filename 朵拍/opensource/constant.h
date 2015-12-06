//
//  constant.h
//  EducationPlus
//
//  Created by lilin on 15/9/26.
//  Copyright (c) 2015年 五方科技. All rights reserved.
//

#ifndef EducationPlus_constant_h
#define EducationPlus_constant_h

#import <SVProgressHUD/SVProgressHUD.h>
static CGFloat const kLoginPaddingLeftWidth = 18.0;
static CGFloat const kPaddingLeftWidth = 15.0;

#define KDPPhotoQualityKey @"KDPPhotoQualityKey"//拍照品质
#define KDPRecodeQualityKey @"KDPRecodeQualityKey"//摄影品质
#define KDPCountBackFaceKey @"KDPCountBackFaceKey"//倒数 人脸追踪
#define KDPCountBackTeleControllerKey @"KDPCountBackTeleControllerKey"//倒数遥控器
#define KDPCountBackVoiceRemindKey @"KDPCountBackVoiceRemindKey"//倒数声音 提醒
#define KDPExposeCompensationKey @"KDPExposeCompensationKey"//曝光补偿

//定义tableView 的各种状态
typedef NS_ENUM(NSUInteger, HNTableViewState) {
    HNTableViewNoDataState,//无数据
    HNTableViewLoadingState,//加载中
    HNTableViewNetUnReachableState,//无网络
    HNTableViewTimeOutState,//网络差
};

//barbuttonitem的类型
typedef NS_ENUM(NSInteger, HNBarbuttonItemStyle) {
    HNBarbuttonItemStyleSetting = 0,//设置
    HNBarbuttonItemStyleMore,//更多
    HNBarbuttonItemStyleCamera,//相机
};

//barbuttonitem的类型
typedef NS_ENUM(NSInteger, HNSettingCellStyle) {
    HNSettingCellHeadViewStyle = 0,//设置
    HNSettingCellHeadViewArrowStyle = 1,//设置

};

typedef NS_ENUM(NSUInteger, HNAreaCodeType) {
    HNAreaCodeHunanType = 1,//无数据
    HNAreaCodeSiChuanType = 2
};

typedef NS_ENUM(NSInteger, HNOrderStatus) {
    HNOrderStatusAll = -1,           //获取所有订单
    HNOrderStatusCanceled = 0,      //已取消
    HNOrderStatusUnPay = 1,         //待支付
    HNOrderStatusUnDispatch = 2,    //待发货
    HNOrderStatusDispatched = 3,    //待收货
    HNOrderStatusTradeSuccess = 4,  //交易成功
    HNOrderStatusRefunding = 5,     //退单中
    HNOrderStatusRefunded = 6,      //退单成功
};

#endif
