//
//  ViewController.m
//  RedPacket
//
//  Created by 林 李 on 15/5/19.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <objc/runtime.h>
#import "UIColor+utils.h"
#import "HNNavigationController.h"
#import "HNTabBarController.h"
NSString const *UITableViewKey = @"UITableViewKey";

@interface HNViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, copy) void (^leftbarbuttonItemAction)(void);
@property (nonatomic, copy) void (^rightbarbuttonItemAction)(void);
@end

@implementation HNViewController
@synthesize state = _state;
#pragma -mark 生命周期
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor baseViewControllerColor];
    if ([self.navigationController.viewControllers indexOfObject:self]) {
//        if (!IOS7_LATER) {
//            __weak typeof(self) this = self;
//            [self configureLeftBackBarbuttonItemStyleWithAction:^{
//                [this.navigationController popViewControllerAnimated:YES];
//            }];
//        }
        __weak typeof(self) this = self;
        [self configureLeftBackBarbuttonItemStyleWithAction:^{
            [this.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [self setDefaultBackBarButtonItem];
    }
    
    
    if (self.navigationController.navigationBar.translucent) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.mm_drawerController.openDrawerGestureModeMask == MMOpenDrawerGestureModeNone) {
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }
}


-(void)dealloc{
    UITableView* tableView = objc_getAssociatedObject(self, &UITableViewKey);
    if (tableView) {
        tableView.emptyDataSetDelegate = nil;
        tableView.emptyDataSetSource = nil;
        objc_removeAssociatedObjects(self);
    }
}

#pragma setter getter
-(HNTableViewState)state{
    return _state;
}

-(void)setState:(HNTableViewState)state{
    UITableView* tableView = objc_getAssociatedObject(self, &UITableViewKey);
    if (tableView) {
        [tableView reloadEmptyDataSet];
    }
    _state = state;
}

#pragma -mark 静态
+ (UIViewController *)presentingViewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[HNTabBarController class]]) {
        result = [(HNTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

+ (void)presentController:(UIViewController *)viewController{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [[HNNavigationController alloc] initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:viewController action:@selector(dismissModalViewControllerAnimated:)];
    [[self presentingViewController] presentViewController:nav animated:YES completion:nil];

}

#pragma -mark BarButtonItem
-(void)setDefaultBackBarButtonItem{
    UIImage *backButtonBackgroundImage = [UIImage imageNamed:@"back"];
    backButtonBackgroundImage = [backButtonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonBackgroundImage.size.width, 0, 0)];
    
    id appearance = [UIBarButtonItem appearanceWhenContainedIn:[NSClassFromString(@"HNNavigationController") class], nil];
    [appearance setBackButtonBackgroundImage:backButtonBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:NULL];
    self.navigationItem.backBarButtonItem = backBarButton;
}

- (void)configureLeftBackBarbuttonItemStyleWithAction:(void (^)(void))action{
    [self configureLeftBarButton:^(UIButton *leftButton) {
        UIImage *backButtonBackgroundImage = [UIImage imageNamed:@"back"];
        backButtonBackgroundImage = [backButtonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonBackgroundImage.size.width, 0, 0)];
        [leftButton setImage:backButtonBackgroundImage forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, 25, 25);
    } action:action];
}

- (void)configureLeftBarButton:(void(^)(UIButton* leftButton))configureBlock action:(void (^)(void))action{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    configureBlock(leftButton);
    
    [leftButton addTarget:self action:@selector(clickedLeftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];

    [self.navigationItem setLeftBarButtonItem:[[[UIBarButtonItem alloc]init] initWithCustomView:leftButton]];
    self.leftbarbuttonItemAction = action;
}

- (void)configureRigthtBarButton:(void(^)(UIButton* rightButton))configureBlock action:(void (^)(void))action{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    configureBlock(rightButton);
   
    [rightButton addTarget:self action:@selector(clickedRightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]init] initWithCustomView:rightButton]];
    self.rightbarbuttonItemAction = action;

}

- (void)configureLeftBarbuttonItemStyle:(HNBarbuttonItemStyle)style action:(void (^)(void))action{
    switch (style) {
        case HNBarbuttonItemStyleSetting: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedLeftBarButtonItemAction)];
            break;
        }
        case HNBarbuttonItemStyleMore: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedLeftBarButtonItemAction)];
            break;
        }
        case HNBarbuttonItemStyleCamera: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedLeftBarButtonItemAction)];
            break;
        }
        default:
            break;
    }
    self.leftbarbuttonItemAction = action;
}

- (void)configureRightBarbuttonItemStyle:(HNBarbuttonItemStyle)style action:(void (^)(void))action{
    switch (style) {
        case HNBarbuttonItemStyleSetting: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedRightBarButtonItemAction)];
            break;
        }
        case HNBarbuttonItemStyleMore: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedRightBarButtonItemAction)];
            break;
        }
        case HNBarbuttonItemStyleCamera: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedRightBarButtonItemAction)];
            break;
        }
        default:
            break;
    }
    self.rightbarbuttonItemAction = action;
}

- (void)clickedLeftBarButtonItemAction {
    if (self.leftbarbuttonItemAction) {
        self.leftbarbuttonItemAction();
    }
}

- (void)clickedRightBarButtonItemAction {
    if (self.rightbarbuttonItemAction) {
        self.rightbarbuttonItemAction();
    }
}

- (void)setupBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

#pragma -mark 惰性初始化
-(void)configureEmptyDataSetWith:(UITableView*)tableView{
    if (tableView) {
        objc_setAssociatedObject(self, &UITableViewKey, tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
    }
}

#pragma -mark DZNEMPTYSET 空数据处理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;{
    if (self.state == HNTableViewLoadingState) {
        return [UIImage sd_animatedGIFNamed:@"loading_circle"];
    }
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView;{
    return [UIColor loadingBackgroundColor];
}

-(CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView{
    return CGPointMake(0, -64);
}



//这个方法不实现会有一个DZNEmptyDataSet奔溃的bug
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}
@end