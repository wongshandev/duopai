//
//  HNLeftSideDrawerController.m
//  RedPacket
//
//  Created by 林 李 on 15/5/28.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNLeftSideDrawerController.h"
#import "UIScrollView+Parallax.h"
#import "HNLeftBaseDrawerCell.h"
#import "HNProfileHeaderView.h"
#import "HNMySettingController.h"
#import "JKImagePickerController.h"
#import "HNAboutViewController.h"
static NSString* categoryCell = @"leftCell";
//static float const NAVBAR_CHANGE_POINT = 50;
@interface HNLeftSideDrawerController ()<JKImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView* parentParallaxdView;
@property (nonatomic, strong) HNProfileHeaderView* parenteHeadView;
@property (nonatomic, strong) NSArray* drawerMenus;
@end

@implementation HNLeftSideDrawerController

-(void)registerCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"HNLeftBaseDrawerCell" bundle:nil] forCellReuseIdentifier:categoryCell];
}

-(void)initData
{
//    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    self.drawerMenus = @[@"蓝牙连接",@"照片浏览",@"关于我们",@"个人设置"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self initData];
    
    //去掉Separator 需要同时设置 cell 和tableview
    self.tableView.separatorColor = [UIColor colorFromHexCode:@"3a3a3a"];
    //tableview
    [self.tableView addParallaxWithView: ({
        _parentParallaxdView= [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, self.self.mm_visibleDrawerFrame.size.width, self.mm_visibleDrawerFrame.size.width * (25./32))];
        _parentParallaxdView.image = [UIImage imageNamed:@"sidebar_user_bg"];
        //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover"]];
        [_parentParallaxdView setContentMode:UIViewContentModeScaleAspectFill];//理解这个的重要性
        [_parentParallaxdView setFrame:_parentParallaxdView.bounds];
        //[_parentParallaxdView addSubview:imageView];
        
        _parenteHeadView = (HNProfileHeaderView*)[[[NSBundle mainBundle] loadNibNamed:@"HNProfileHeaderView" owner:nil options:nil] firstObject];
        _parenteHeadView.tag = 101;// 这一块 以后 需要整合 //关于 添加 parallax view 的模块
        [_parentParallaxdView addSubview:_parenteHeadView];
        
        _parentParallaxdView;
    }) andHeight:200];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.drawerMenus.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNLeftBaseDrawerCell* cell = (HNLeftBaseDrawerCell*)[tableView dequeueReusableCellWithIdentifier:categoryCell];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.drawerMenus[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sidebar_icon_0%td",(indexPath.row + 1)]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case HNLeftDrawerSelectionHomepage:
        {
            [self.mm_drawerController
             setCenterViewController:self.mm_drawerController.centerViewController
             withCloseAnimation:YES
             completion:nil];
            break;
        }
        case HNLeftDrawerSelectionPhotobrowser:
        {
//            __weak typeof(self) this = self;
            JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.showsCancelButton = YES;
            imagePickerController.maximumNumberOfSelection = 9;
//            imagePickerController.allowsMultipleSelection = YES;
//            imagePickerController.minimumNumberOfSelection = 1;
            //imagePickerController.maximumNumberOfSelection = [this maximumNumberOfImage];
            //imagePickerController.selectedAssetArray = this.assetsArray;
            [(UINavigationController*)self.mm_drawerController.centerViewController  pushViewController:imagePickerController animated:NO];
            [self.mm_drawerController
             setCenterViewController:self.mm_drawerController.centerViewController
             withCloseAnimation:YES
             completion:nil];//            HNNavigationController *navigationController = [[HNNavigationController alloc] initWithRootViewController:imagePickerController];
//            [this presentViewController:navigationController animated:YES completion:NULL];
            break;
        }
        case HNLeftDrawerSelectionAboutUs:
        {
            HNAboutViewController* setting = [[HNAboutViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [(UINavigationController*)self.mm_drawerController.centerViewController  pushViewController:setting animated:NO];
            [self.mm_drawerController
             setCenterViewController:self.mm_drawerController.centerViewController
             withCloseAnimation:YES
             completion:nil];
            break;
        }
        case HNLeftDrawerSelectionMySetting:
        {
            HNMySettingController* setting = [[HNMySettingController alloc] initWithNibName:@"HNMySettingController" bundle:nil];
            [(UINavigationController*)self.mm_drawerController.centerViewController  pushViewController:setting animated:NO];
            [self.mm_drawerController
             setCenterViewController:self.mm_drawerController.centerViewController
             withCloseAnimation:YES
             completion:nil];
            break;
        }
        default:
        {
            [self.mm_drawerController
             setCenterViewController:self.mm_drawerController.centerViewController
             withCloseAnimation:YES
             completion:nil];
            break;
        }
    }
}

- (void)JKImagePickerControllerDidCancel:(JKImagePickerController *)imagePicker{
    [imagePicker.navigationController popViewControllerAnimated:YES];
}
@end
