//
//  AppDelegate.m
//  我爱拍
//
//  Created by lilin on 15/11/23.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "AppDelegate.h"
#import "HNDrawerController.h"
#import "HNLeftSideDrawerController.h"
#import "HNDrawerVisualStateManager.h"

@interface AppDelegate ()
@property (nonatomic,strong) HNDrawerController * drawerController;
@property (nonatomic,strong) UIStoryboard * storyboard;
@end

@implementation AppDelegate

// test push request add
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIViewController* rootViewController =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HNDrawerController"];
    
    if (rootViewController && [rootViewController isKindOfClass:[HNDrawerController class]]) {
        _drawerController = (HNDrawerController *)rootViewController;
        _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HNLeftSideDrawerController * leftSideDrawerViewController = [[HNLeftSideDrawerController alloc] initWithNibName:@"HNLeftSideDrawerController" bundle:nil];
        UIViewController * centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyBlessNavigationController"];
        self.drawerController.centerViewController = centerViewController;
        self.drawerController.leftDrawerViewController = leftSideDrawerViewController;
        
        [self.drawerController setShowsShadow:YES];
        [self.drawerController setMaximumLeftDrawerWidth:240];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [self.drawerController setShouldStretchDrawer:NO];
        [self.drawerController
         setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
             MMDrawerControllerDrawerVisualStateBlock block;
             block = [[HNDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
             if(block){
                 block(drawerController, drawerSide, percentVisible);
             }
         }];
    }
    window.rootViewController = rootViewController;
    self.window=window;
    [window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
