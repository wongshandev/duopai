//
//  HNSideDrawerViewController.h
//  RedPacket
//
//  Created by 林 李 on 15/5/28.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNDrawerViewController.h"
typedef NS_ENUM(NSInteger, MMDrawerSection){
    MMDrawerSectionViewSelection,
    MMDrawerSectionDrawerWidth,
    MMDrawerSectionShadowToggle,
    MMDrawerSectionOpenDrawerGestures,
    MMDrawerSectionCloseDrawerGestures,
    MMDrawerSectionCenterHiddenInteraction,
    MMDrawerSectionStretchDrawer,
};
@interface HNSideDrawerViewController : HNDrawerViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * drawerWidths;
@end
