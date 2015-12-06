//
//  ViewController.h
//  RedPacket
//
//  Created by 林 李 on 15/5/19.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImage+GIF.h>
#import "constant.h"
//建议所有的控件都创建 xib 这个类只为不透明的导航条服务
//暂时不支持xib 创建tableView
//这个类最好不要存在tableView的实例 
@interface HNViewController : UIViewController


@property(nonatomic,assign)HNTableViewState state;//table的状态

-(void)configureEmptyDataSetWith:(UITableView*)tableView;

#pragma -mark barbuttonitem 方法
//设置背景图片
- (void)setupBackgroundImage:(UIImage *)backgroundImage;

//配置回退按钮 主要用于ios7 的适配
- (void)configureLeftBackBarbuttonItemStyleWithAction:(void (^)(void))action;

//配置左边的按钮 按钮可以自定义
- (void)configureLeftBarButton:(void(^)(UIButton* leftButton))configureBlock action:(void (^)(void))action;

//配置系统类型的左边按钮 根据提供的图片来显示
- (void)configureLeftBarbuttonItemStyle:(HNBarbuttonItemStyle)style action:(void (^)(void))action;

//配置右边的按钮 按钮可以自定义
- (void)configureRigthtBarButton:(void(^)(UIButton* rightButton))configureBlock action:(void (^)(void))action;

//配置系统类型的右边按钮 根据提供的图片来显示
- (void)configureRightBarbuttonItemStyle:(HNBarbuttonItemStyle)style action:(void (^)(void))action;

+ (UIViewController *)presentingViewController;
+ (void)presentController:(UIViewController *)viewController;

@end