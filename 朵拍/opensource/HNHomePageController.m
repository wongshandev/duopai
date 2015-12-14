//
//  HNHomePageController.m
//  我爱拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNHomePageController.h"
#import "HNRecordViewController.h"
#import "HNHomeTableCell.h"
#import "CameraMian.h"
#import "BabyBluetooth.h"

#define channelOnPeropheralView nil

#ifdef __TI_BLE_CONTROL__
CBCentralManager *manager;
CBPeripheral *_peripheral;
/* 写数据的时候要用到这个 */
CBCharacteristic *writeCharacteristic;
NSString * BleTitle = nil;
/* 协议中的流水号。累加下去。 */
short int sendSerialNumber = 0;
#endif


@interface HNHomePageController ()<deviceShouldRotationDelegate>{
//    UITableView *tableView;
NSMutableArray *peripherals;
NSMutableArray *peripheralsAD;
}

@property(nonatomic,strong)BabyBluetooth *baby;

@end

@implementation HNHomePageController
-(void)dealloc{
    NSLog(@"dealloc  HNHomePageController");
}
-(void)initTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"HNHomeTableCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.navigationController.toolbarHidden = NO;
//    UIBarButtonItem* item1 = [[UIBarButtonItem alloc] initWithTitle:@"打开" style:UIBarButtonItemStyleBordered target:self action:@selector(openDevice)];
//    UIBarButtonItem* item12 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem* item2 = [[UIBarButtonItem alloc] initWithTitle:@"左转" style:UIBarButtonItemStyleBordered target:self action:@selector(turnleftDevice)];
//    UIBarButtonItem* item23 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem* item3 = [[UIBarButtonItem alloc] initWithTitle:@"右转" style:UIBarButtonItemStyleBordered target:self action:@selector(turnRightDevice)];
//    UIBarButtonItem* item34 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem* item4 = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(closeDevice)];
//    self.toolbarItems = @[item1,item12,item2,item23,item3,item34,item4];
}

-(void)openDevice{
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_open length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
    /* 流水号是累加的。每一次发送命令，流水号都要累加一次。 */
    //    sendSerialNumber += 1;
    //    memcpy(cotrol_turn_open+4, &sendSerialNumber, 4);
}

-(void)turnleftDevice{
    sendSerialNumber += 1;
    memcpy(cotrol_turn_right+4, &sendSerialNumber, 4);
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_left length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

-(void)turnRightDevice{
    sendSerialNumber += 1;
    memcpy(cotrol_turn_right+4, &sendSerialNumber, 4);
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_right length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
}
-(void)closeDevice{
//    sendSerialNumber += 1;
//    memcpy(cotrol_turn_right+4, &sendSerialNumber, 4);
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_closed length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

-(void)deviceShouldTurnLeft{
    [self turnleftDevice];
}

-(void)deviceShouldTurnRight{
    [self turnRightDevice];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
#ifdef __TI_BLE_CONTROL__
    //第一步，启动蓝牙管理器
    NSLog(@"第一步，启动蓝牙管理器。");
    self.title = @"正在打开蓝牙设备";
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
//    //初始化其他数据 init other
//    peripherals = [[NSMutableArray alloc]init];
//    peripheralsAD = [[NSMutableArray alloc]init];
//    
//    //初始化BabyBluetooth 蓝牙库
//    _baby = [BabyBluetooth shareBabyBluetooth];
//    //设置蓝牙委托
//    [self babyDelegate];
    
#endif
}

//-(void)viewDidAppear:(BOOL)animated{
//    NSLog(@"viewDidAppear");
//    //停止之前的连接
//    [_baby cancelAllPeripheralsConnection];
//    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
//    _baby.scanForPeripherals().begin();
//    //baby.scanForPeripherals().begin().stop(10);
//}

-(void)loadData:(CBPeripheral*)currPeripheral{
    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
//    _baby.having(currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
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
#ifdef __HS_CAMERA__
    CameraMian * vc = [[CameraMian alloc] initWithNibName:@"CameraMian" bundle:nil];
    vc.deviceDelgate = self;
    [self.navigationController pushViewController:vc animated:YES];
#else
    HNRecordViewController* recorder = [[HNRecordViewController alloc] initWithNibName:@"HNRecordViewController" bundle:nil];
    [self.navigationController pushViewController:recorder animated:YES];
#endif
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
            self.title = @"正在扫描";
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
    self.title = @"正在连接机器人";
    _peripheral = peripheral;
    NSLog(@"%@",_peripheral);
    [manager stopScan];
    [manager connectPeripheral:_peripheral options:nil];
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:nil];
    self.title = @"正在初始化....";
//    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_right length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
}

//外设断开了
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"断开了。。。。");
    self.title = @"蓝牙已断开";
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"第二步，蓝牙已打开,扫描外设");
            self.title = @"正在扫描";
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
        
        if ([c.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicWirteUUID]])
        {
            writeCharacteristic = c;
            [SVProgressHUD showSuccessWithStatus:@"已连接,您需要点击打开设备"];
             self.title = @"已经连接";
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
        //[self BleControlTurnLeft];
    }
}

- (void)BleControlTurnOpen{
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_open length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
    /* 流水号是累加的。每一次发送命令，流水号都要累加一次。 */
//    sendSerialNumber += 1;
//    memcpy(cotrol_turn_open+4, &sendSerialNumber, 4);
}


- (void)BleControlTurnRight{
    /* 流水号是累加的。每一次发送命令，流水号都要累加一次。 */
    sendSerialNumber += 1;
    memcpy(cotrol_turn_right+4, &sendSerialNumber, 4);
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_right length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (void)BleControlTurnLeft
{
    sendSerialNumber += 1;
    memcpy(cotrol_turn_right+4, &sendSerialNumber, 4);
    [_peripheral writeValue:[NSData dataWithBytes:cotrol_turn_left length:16] forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
}



#endif
@end
