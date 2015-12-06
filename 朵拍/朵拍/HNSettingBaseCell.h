//
//  HNSettingBaseCell.h
//  RedPacket
//
//  Created by 林 李 on 15/5/29.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNSettingBaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;


@property (copy, nonatomic)void (^switchValueChangedBlock)(UISwitch* switcher);
@end
