//
//  HNMySettingController.m
//  RedPacket
//
//  Created by 林 李 on 15/5/29.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNMySettingController.h"
#import "HNSettingBaseCell.h"
#import "HNPickerViewController.h"

@interface HNMySettingController ()//<RNFrostedSidebarDelegate>
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) NSArray *settingArray;
@end

static NSString* baseCell = @"baseCell";

@implementation HNMySettingController
- (void)action:(id)sender {
    NSLog(@"Button pressed.");
}

-(void)setUpTableView
{
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"HNSettingBaseCell" bundle:nil] forCellReuseIdentifier:baseCell];
}

-(void)initData
{
    self.title = @"个人设置";
    NSArray* tmparray = @[@"照片品质",@"录影品质",@"倒数(人脸追踪)",@"倒数(遥控器)",@"倒数(提示声)",@"曝光补偿"];
    self.settingArray = tmparray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUpTableView];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    [self configureRightBarbuttonItemStyle:HNBarbuttonItemStyleCamera action:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //[TSMessage setDefaultViewController:self];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"通用";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.settingArray.count;
}

-(NSString*)settingKeyWithrow:(NSInteger)row{
    switch (row) {
        case 0:
            return KDPPhotoQualityKey;
        case 1:
            return KDPRecodeQualityKey;
        case 2:
            return KDPCountBackFaceKey;
        case 3:
            return KDPCountBackTeleControllerKey;
        case 4:
            return KDPCountBackVoiceRemindKey;
        case 5:
            return KDPExposeCompensationKey;
        default:
            return @"朵拍";
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HNSettingBaseCell* cell = (HNSettingBaseCell*)[tableView dequeueReusableCellWithIdentifier:baseCell forIndexPath:indexPath];
        cell.titleLabel.text = self.settingArray[indexPath.row];
        cell.switcher.hidden = !(indexPath.row == 4 || indexPath.row == 5);
        cell.valueLabel.hidden = (indexPath.row == 4 || indexPath.row == 5);
        if ((indexPath.row == 4 || indexPath.row == 5)) {
            [cell.switcher setOn:[[NSUserDefaults standardUserDefaults] boolForKey:[self settingKeyWithrow:indexPath.row]]] ;
            __weak typeof(self) this = self;
            cell.switchValueChangedBlock = ^(UISwitch* switcher){
                [[NSUserDefaults standardUserDefaults] setBool:switcher.isOn forKey:[this settingKeyWithrow:indexPath.row]];
            };
        }else{
            cell.valueLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:[self settingKeyWithrow:indexPath.row]];
        }
        return cell;
    }else{
        static NSString* exitCell = @"exitCell";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:exitCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exitCell];
        }
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        HNPickerViewController* picker = [HNPickerViewController pickerWithPickeType:HNPickerTypePhoto pickList:@[@"高",@"中",@"低"] completeBlock:^(NSString *pickerString) {
            
        }];
        [self.navigationController pushViewController:picker animated:YES];
    }else if (indexPath.row == 1){
        HNPickerViewController* picker = [HNPickerViewController pickerWithPickeType:HNPickerTypeVideo pickList:@[@"高",@"中",@"低"] completeBlock:^(NSString *pickerString) {
            
        }];
        [self.navigationController pushViewController:picker animated:YES];
    }else if (indexPath.row == 2){
        HNPickerViewController* picker = [HNPickerViewController pickerWithPickeType:HNPickerTypeCountFace pickList:@[@"快(2秒)",@"普通(3秒)",@"慢(5秒)"] completeBlock:^(NSString *pickerString) {
            
        }];
        [self.navigationController pushViewController:picker animated:YES];
    }else if (indexPath.row == 3){
        HNPickerViewController* picker = [HNPickerViewController pickerWithPickeType:HNPickerTypeCountTelControl pickList:@[@"立即",@"1秒",@"2秒",@"3秒",@"4秒",@"5秒"] completeBlock:^(NSString *pickerString) {
            
        }];
        [self.navigationController pushViewController:picker animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
