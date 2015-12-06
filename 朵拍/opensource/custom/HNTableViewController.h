//
//  HNBTableViewController.h
//  huinongbao
//
//  Created by 林 李 on 15/4/14.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constant.h"
/**
 *  本类完全继承 UITableViewController 用来完善 UITableViewController 的相关属性
 */
@interface HNTableViewController : UITableViewController
@property(nonatomic,assign)HNTableViewState state;//table的状态


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

@end
