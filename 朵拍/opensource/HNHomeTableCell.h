//
//  HNHomeTableCell.h
//  我爱拍
//
//  Created by lilin on 15/12/6.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNHomeTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UILabel *connectStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *connectStatusImageView;

@end
