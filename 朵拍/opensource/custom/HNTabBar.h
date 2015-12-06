//
//  HNTabBar.h
//  luckytree
//
//  Created by lilin on 14-4-29.
//  Copyright (c) 2014年 cnhnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNTabBarController.h"
@class HNTabBar;
@protocol HNTabBarDelegate<NSObject>
-(void)tabBar:(HNTabBar*)tabbar didSelectItem:(NSInteger)selectIndex;
@end

@interface HNTabBarItem : UIView
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
@end

@interface HNTabBar : UIView
@property(nonatomic,weak)id<HNTabBarDelegate> delegate;
@property(nonatomic,assign)NSUInteger selectedIndex;
@property(nonatomic,strong)UIColor* barTintColor;
@property(nonatomic,strong)UIColor* tintColor;
@property(nonatomic,strong)UIColor* normaltintColor;
@end
