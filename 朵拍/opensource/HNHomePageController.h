//
//  HNHomePageController.h
//  朵拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNTableViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

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
/* 右转 */
static unsigned char cotrol_turn_right[16] = {0xfa,0x01,0x00,0x0b,0x00,0x01,0x00,0x01, 0x00,0x01, 0x29,0x02,0x01,0x00,0x00,0xaf};

#endif

@interface HNHomePageController : HNTableViewController <CBCentralManagerDelegate,CBPeripheralDelegate>
@end
