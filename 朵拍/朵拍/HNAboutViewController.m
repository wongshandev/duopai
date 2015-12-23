//
//  HNAboutViewController.m
//  朵拍
//
//  Created by 五方科技 on 15/12/21.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNAboutViewController.h"
#import "HNAboutBaseCell.h"
#import "HNAboutHeaderCell.h"

#import "TOWebViewController.h"
@interface HNAboutViewController ()
@property(nonatomic,strong)NSArray* sectionArray0;
@property(nonatomic,strong)NSArray* sectionArray1;
@end

@implementation HNAboutViewController
-(void)initData{
    self.sectionArray0 = @[@{},@{@"name":@"软件二维码",@"value":@""},@{@"name":@"官方网站",@"value":@"http://www.agpc.cn"},@{@"name":@"官方微信",@"value":@"agpc_cn"},@{@"name":@"全国服务热线",@"value":@"4001668398"}];
    self.sectionArray1 = @[@{@"name":@"版权所有",@"value":@"深圳鑫益家科技股份有限公司"},@{@"name":@"服务条款",@"value":@""}];
}

-(void)initTable{
    [self.tableView registerNib:[UINib nibWithNibName:@"HNAboutBaseCell" bundle:nil] forCellReuseIdentifier:@"base"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HNAboutHeaderCell" bundle:nil] forCellReuseIdentifier:@"header"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initTable];
    self.title = @"关于";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 5 : 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HNAboutHeaderCell* cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
            return cell;
        }else{
            HNAboutBaseCell* cell = [tableView dequeueReusableCellWithIdentifier:@"base"];
            cell.nameLabel.text = self.sectionArray0[indexPath.row][@"name"];
            cell.ValueLabel.text = self.sectionArray0[indexPath.row][@"value"];
            cell.iconView.hidden = indexPath.row != 1;
            return cell;
        }
    }else{
        HNAboutBaseCell* cell = [tableView dequeueReusableCellWithIdentifier:@"base"];
        cell.nameLabel.text = self.sectionArray1[indexPath.row][@"name"];
        cell.ValueLabel.text = self.sectionArray1[indexPath.row][@"value"];
        cell.iconView.hidden = YES;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
    }
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            TOWebViewController* web = [[TOWebViewController alloc] initWithURLString:@"http://www.agpc.cn"];
            web.showLoadingBar = NO;
            web.showPageTitles = NO;
            web.navigationButtonsHidden = YES;
            [self.navigationController pushViewController:web animated:YES];
        }
    }
}
@end
