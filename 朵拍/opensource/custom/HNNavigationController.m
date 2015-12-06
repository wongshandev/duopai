//
//  HNBNavigationController.m
//  huinongbao
//
//  Created by 林 李 on 15/4/14.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNNavigationController.h"
#import <objc/runtime.h>
#import "UIColor+utils.h"
@interface HNNavigationController ()
@end

@implementation HNNavigationController
#pragma mark - 生命周期
-(UIStatusBarStyle)preferredStatusBarStyle{
    return [self.visibleViewController preferredStatusBarStyle];;
}

-(BOOL)prefersStatusBarHidden{
    return [self.visibleViewController prefersStatusBarHidden];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self resetNavigationBar];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 设置
-(void)resetNavigationBar
{
    //    UIImage * navbarImage = [UIImage navBackgroundImageWithBackgroundColor:[UIColor navgaitionBarTintColor] bottomLineColor:[UIColor navgaitionBottomLineColor]];
    [self.navigationBar setBarTintColor:[UIColor navgaitionBarTintColor]];

    //[self.navigationBar setBackgroundImage:navbarImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor navgaitionTintColor];
    //self.navigationBar.translucent = NO;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor navgaitionTintColor]};
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

#pragma mark - 旋转代理
-(BOOL)shouldAutorotate
{
    return YES;

//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        return [self.visibleViewController shouldAutorotate];
//
//    }else{
//        return NO;
//    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;

//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }else{
////        return UIInterfaceOrientationMaskAllButUpsideDown;
////        return UIInterfaceOrientationMaskPortrait;
//        return [self.visibleViewController supportedInterfaceOrientations];
//    }
}
@end
