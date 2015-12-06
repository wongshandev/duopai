//
//  HNDrawerController.m
//  RedPacket
//
//  Created by 林 李 on 15/5/28.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import "HNDrawerController.h"
@interface HNDrawerController ()

@end

@implementation HNDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark - 旋转代理
-(BOOL)shouldAutorotate
{
    return [self.centerViewController shouldAutorotate];//[self.visibleViewController shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }else{
        //return UIInterfaceOrientationMaskAllButUpsideDown;
        return [self.centerViewController supportedInterfaceOrientations];
    }
}
@end
