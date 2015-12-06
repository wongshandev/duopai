//
//  HNHomePageController.m
//  朵拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNHomePageController.h"
#import "HNRecordViewController.h"

#ifdef __TI_BLE_CONTROL__
CBCentralManager *manager;
CBPeripheral *_peripheral;
/* 写数据的时候要用到这个 */
CBCharacteristic *writeCharacteristic;
#endif
@interface HNHomePageController ()

@end

@implementation HNHomePageController
-(void)initTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"HNHomeTableCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
#ifdef __TI_BLE_CONTROL__
    //第一步，启动蓝牙管理器
    NSLog(@"第一步，启动蓝牙管理器。");
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
#endif
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.mm_drawerController.openDrawerGestureModeMask == MMOpenDrawerGestureModeNone) {
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }
}

-(IBAction)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (IBAction)onRecordButtonClicked:(UIButton *)sender {
    HNRecordViewController* recorder = [[HNRecordViewController alloc] initWithNibName:@"HNRecordViewController" bundle:nil];
    [self.navigationController pushViewController:recorder animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

#ifdef __TI_BLE_CONTROL__
//开始写数据
- (void)BLEwriteValue:(NSString *)command per:(CBPeripheral *)p charact:(CBCharacteristic *)writechararcter
{
    NSLog(@"发送数据 %@",command);
    
    if (command != nil)
    {
        //[p writeValue:[command dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:writechararcter type:CBCharacteristicWriteWithResponse];
    }
}

//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"第二步，蓝牙已打开,扫描外设");
            if(manager.state == CBCentralManagerStatePoweredOn)
                [manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];   break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"设备不支持BLE4.0");
            break;
        default:
            NSLog(@"没打开蓝牙");
            break;
    }
}
//查到外设后，停止扫描，连接设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"第三步，已发现蓝牙设备，停止扫描。。开始链接");
    _peripheral = peripheral;
    NSLog(@"%@",_peripheral);
    [manager stopScan];
    [manager connectPeripheral:_peripheral options:nil];
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:nil];
    NSLog(@"第四步，已经链接上蓝牙了。开始发送数据 向左转。。。写数据");
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_right length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
}
//外设断开了
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"断开了。。。。");
    
}
/*
 *  @method UUIDToString
 *
 *  @param UUID UUID to convert to string
 *
 *  @returns Pointer to a character buffer containing UUID in string representation
 *
 *  @discussion UUIDToString converts the data of a CFUUIDRef class to a character pointer for easy printout using printf()
 *
 */
-(const char *) UUIDToString:(CFUUIDRef)UUID {
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
    
}

//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@",error);
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"连接失败，请重试。",nil)];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:250.0/255.0f green:250.0/255.0f blue:250.0/255.0f alpha:0.75f]];
}
//已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    int i=0;

    for (CBService *s in peripheral.services) {
        NSLog(@"%d :服务 UUID: %@(%@)",i,s.UUID.data,s.UUID);
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
    }
}

//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    _peripheral = peripheral;
    for (CBCharacteristic *c in service.characteristics) {
        NSLog(@"特征 UUID: %@ :(%@)",c.UUID.data,c.UUID);
        
        writeCharacteristic = c;
        if ([c.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]])
        {
            writeCharacteristic = c;
        }
    }
}
//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didUpdateValueForCharacteristic%@",[[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding]);
}
//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    // Notification has started
    NSLog(@"peripheral :%@",peripheral);
    if (characteristic.isNotifying)
    {
        [peripheral readValueForCharacteristic:characteristic];
        
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        [manager cancelPeripheralConnection:peripheral];
    }
}
//用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"ERROR: Result of writing to characteristic: %@ of service: %@ with error: %@", characteristic.UUID, characteristic.service.UUID, error);
    }else{
        NSLog(@"发送数据成功");
    }
}


#endif
@end
