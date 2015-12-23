//
//  HNPickerViewController.m
//  我爱拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNPickerViewController.h"

@interface HNPickerViewController ()
@property(nonatomic,strong)NSArray* dataArray;
@property(nonatomic,copy)void (^completeBlock)(NSString* pickerString);
@property(nonatomic,assign)HNPickerType picktype;
@end

@implementation HNPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(HNPickerViewController*)pickerWithPickeType:(HNPickerType)picktype
                                     pickList:(NSArray*)list
                                completeBlock:(void (^)(NSString* pickerString))completeBlock{
    HNPickerViewController* picker = [[HNPickerViewController alloc] initWithStyle:UITableViewStyleGrouped];
    picker.picktype = picktype;
    picker.dataArray = list;
    picker.completeBlock = completeBlock;
    return picker;
}

-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

-(NSString*)title{
    switch (self.picktype) {
        case HNPickerTypePhoto:
            return @"照片品质";
        case HNPickerTypeVideo:
            return @"录影品质";
        case HNPickerTypeCountFace:
            return @"倒数(人脸追踪)";
        case HNPickerTypeCountTelControl:
            return @"倒数(遥控器)";
        default:
            return @"我爱拍";
    }
}

-(NSString*)settingkey{
    switch (self.picktype) {
        case HNPickerTypePhoto:
            return KDPPhotoQualityKey;
        case HNPickerTypeVideo:
            return KDPRecodeQualityKey;
        case HNPickerTypeCountFace:
            return KDPCountBackFaceKey;
        case HNPickerTypeCountTelControl:
            return KDPCountBackTeleControllerKey;
        default:
            return @"我爱拍";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
    }
    
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:[self settingkey]] isEqualToString:[self.dataArray objectAtIndex:indexPath.row]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setValue:[self.dataArray objectAtIndex:indexPath.row] forKey:[self settingkey]];
    
   // AudioServicesPlaySystemSound([[resuleArr objectAtIndex:indexPath.row]integerValue]);
    self.completeBlock([self.dataArray objectAtIndex:indexPath.row] );
    [tableView reloadData];
}

@end
