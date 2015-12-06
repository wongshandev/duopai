//
//  HNBTableViewController.m
//  huinongbao
//
//  Created by 林 李 on 15/4/14.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNTableViewController.h"
#import <SDWebImage/UIImage+GIF.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIColor+utils.h"
@interface HNTableViewController ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, copy) void (^leftbarbuttonItemAction)(void);
@property (nonatomic, copy) void (^rightbarbuttonItemAction)(void);

@end

@implementation HNTableViewController
@synthesize state = _state;

-(void)dealloc{
    self.tableView.emptyDataSetSource = nil;
    self.tableView.emptyDataSetDelegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
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


-(void)setDefaultBackBarButtonItem{
    UIImage *backButtonBackgroundImage = [UIImage imageNamed:@"back"];
    backButtonBackgroundImage = [backButtonBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backButtonBackgroundImage.size.width, 0, 0)];
    
    id appearance = [UIBarButtonItem appearanceWhenContainedIn:[NSClassFromString(@"HNNavigationController") class], nil];
    [appearance setBackButtonBackgroundImage:backButtonBackgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:NULL];
    self.navigationItem.backBarButtonItem = backBarButton;
}


#pragma setter getter
-(HNTableViewState)state{
    return _state;
}

-(void)setState:(HNTableViewState)state{
    _state = state;
    [self.tableView reloadEmptyDataSet];
}

#pragma -mark BarButtonItem
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

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString * text = nil;
    NSDictionary *attributes = nil;
    if (self.state == HNTableViewLoadingState) {
        text = @"Loading";
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                       NSForegroundColorAttributeName: [UIColor loadingTextColor]};
    }else if (self.state == HNTableViewNetUnReachableState) {
        text = @"没有网络";
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                       NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    }else if (self.state == HNTableViewNoDataState) {
        text = @"没有数据";
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                       NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    }else if (self.state == HNTableViewTimeOutState) {
        text = @"网络超时点击重新加载";
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                       NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    }
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//这个 方法不实现会有一个奔溃的bug
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}
@end
