//
//  HNHomePageController.h
//  我爱拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNTableViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface HNHomePageController : HNTableViewController <CBCentralManagerDelegate,CBPeripheralDelegate>

- (void)BleControlTurnRight;
- (void)BleControlTurnLeft;

@end
