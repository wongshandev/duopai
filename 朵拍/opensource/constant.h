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


#ifdef __TI_BLE_CONTROL__
static NSString *const kCharacteristicWirteUUID = @"0000fff1-0000-1000-8000-00805f9b34fb";

static NSString *const kCharacteristicUUID = @"0000fff1-0000-1000-8000-00805f9b34fb";

static NSString *const kServiceUUID = @"0000fff0-0000-1000-8000-00805f9b34fb";


/*
 bb[0] = (byte) 0xFA; //包头
 bb[1] = (byte) 0x01;　//版本号
 bb[2] = (byte) 0x00; //数据包长　２字节
 bb[3] = (byte) 0x0b;　//数据包长　２字节
 
 bb[4] = (byte) 0x00;　//包索引，从１开始累加。2字节
 bb[5] = (byte) 0x01;  //包索引，从１开始累加。2字节
 bb[6] = (byte) 0x00;　//拆包索引，目前都只有一个包。为1,　２字节
 bb[7] = (byte) 0x01;　//拆包索引，目前都只有一个包。为1,　２字节
 
 bb[8] = (byte) 0x00;　//拆包总数，目前为　1,２字节
 bb[9] = (byte) 0x01;//拆包总数，目前为　1,２字节
 
 bb[10] = (byte) 0x29;　//(右转)命令码，这是两个字节，大端，高位在前。所以这是0x29
 bb[11] = (byte) 0x02; //(右转)命令码，这是两个字节，大端，高位在前。所以这是0x01
 
 bb[12] = (byte) 0x01; //是否需要应答。为1
 
 bb[13] = (byte) 0x00; //命令数据长度。目前都是0，２字节
 bb[14] = (byte) 0x00;
 
 bb[15] = (byte) 0xAF; //包尾
 
 */
/* 打开 */
static unsigned char cotrol_turn_open[16] = {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x01,0x01,0x00,0x00,0xaf};
/* 关闭 */
static unsigned char cotrol_turn_closed[16] = {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x00,0x01,0x00,0x00,0xaf};
/* 左转 */
static unsigned char cotrol_turn_left[16] =  {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x02,0x01,0x00,0x00,0xaf};
/* 右转 */
static unsigned char cotrol_turn_right[16] = {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x03,0x01,0x00,0x00,0xaf};
/* 获取电量 */
static unsigned char cotrol_turn_getpower[16] =  {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x04,0x01,0x00,0x00,0xaf};
/* 低电量 */
static unsigned char cotrol_turn_lowpower[16] =  {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x05,0x01,0x00,0x00,0xaf};
static unsigned char cotrol_turn_break[16] =  {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x06,0x01,0x00,0x00,0xaf};


#endif

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

#endif
