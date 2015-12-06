//
//  HNLeftBaseDrawerCell.m
//  RedPacket
//
//  Created by 林 李 on 15/5/28.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNLeftBaseDrawerCell.h"
#import "UIColor+utils.h"
@implementation HNLeftBaseDrawerCell

-(void)setUp
{
    UIView * backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    UIColor * backgroundColor = [UIColor colorFromHexCode:@"2f2f2f"];
    [backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [backgroundView setBackgroundColor:backgroundColor];
    
    [self setBackgroundView:backgroundView];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setHighlightedTextColor:[UIColor lightGrayColor]];
    [self.accessoryView setTintColor:[UIColor whiteColor]];
    
    self.badgeString = @"8";
    self.badgeColor = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeColorHighlighted = [UIColor redColor];
    self.badgeTextColorHighlighted = [UIColor whiteColor];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
       
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
