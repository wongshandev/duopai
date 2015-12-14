//
//  HNHomeTableCell.m
//  我爱拍
//
//  Created by lilin on 15/12/6.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNHomeTableCell.h"

@implementation HNHomeTableCell

- (void)awakeFromNib {
    self.parentView.layer.borderColor = [UIColor colorFromHexCode:@"75CFC7"].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
