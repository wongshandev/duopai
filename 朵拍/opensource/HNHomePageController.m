//
//  HNHomePageController.m
//  朵拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNHomePageController.h"
#import "HNRecordViewController.h"
@interface HNHomePageController ()

@end

@implementation HNHomePageController
-(void)initTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"HNHomeTableCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.mm_drawerController.openDrawerGestureModeMask == MMOpenDrawerGestureModeNone) {
        self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }
}

-(IBAction)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (IBAction)onRecordButtonClicked:(UIButton *)sender {
    HNRecordViewController* recorder = [[HNRecordViewController alloc] initWithNibName:@"HNRecordViewController" bundle:nil];
    [self.navigationController pushViewController:recorder animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

@end
