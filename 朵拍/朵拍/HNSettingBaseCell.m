//
//  HNSettingBaseCell.m
//  RedPacket
//
//  Created by 林 李 on 15/5/29.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNSettingBaseCell.h"

@implementation HNSettingBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)switcherValueChanged:(UISwitch *)sender {
    if (_switchValueChangedBlock) {
        _switchValueChangedBlock(sender);
    }
}
@end
