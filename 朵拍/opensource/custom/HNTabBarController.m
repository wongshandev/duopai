//
//  HNBTabBarController.m
//  huinongbao
//
//  Created by 林 李 on 15/4/14.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNTabBarController.h"
#import "UIColor+utils.h"
@interface HNTabBarController ()<HNTabBarDelegate>

@end

@implementation HNTabBarController
#pragma -mark 自定义
//去除黑线
-(void)customAppearance
{
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

#pragma -mark statusbar
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
}

-(BOOL)prefersStatusBarHidden
{
    return [self.selectedViewController prefersStatusBarHidden];
}

#pragma -mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self customAppearance];
//    _tabbar = [[HNTabBar alloc] initWithFrame:self.tabBar.bounds];
//    _tabbar.barTintColor = [UIColor colorFromHexCode:@"f6f6f6"];
//    _tabbar.tintColor = [UIColor navgaitionBarTintColor];
//    _tabbar.delegate = self;
//    _tabbar.opaque = YES;
//    [self.tabBar insertSubview:_tabbar atIndex:0];
    
  
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillLayoutSubviews
{
   // [self.tabBar bringSubviewToFront:_tabbar];
}

- (void)dealloc{
    
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
   // _tabbar.selectedIndex = selectedIndex;
}

-(void)tabBar:(HNTabBar *)tabBar didSelectItem:(NSInteger)item{
    self.selectedIndex = item;
}
@end
