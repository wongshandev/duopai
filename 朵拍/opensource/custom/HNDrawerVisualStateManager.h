//
//  HNDrawerVisualStateManager.h
//  RedPacket
//
//  Created by 林 李 on 15/5/28.
//  Copyright (c) 2015年 cnhnb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MMDrawerController/MMDrawerVisualState.h>

typedef NS_ENUM(NSInteger, MMDrawerAnimationType){
    MMDrawerAnimationTypeNone,
    MMDrawerAnimationTypeSlide,
    MMDrawerAnimationTypeSlideAndScale,
    MMDrawerAnimationTypeSwingingDoor,
    MMDrawerAnimationTypeParallax,
};

@interface HNDrawerVisualStateManager : NSObject
@property (nonatomic,assign) MMDrawerAnimationType leftDrawerAnimationType;
@property (nonatomic,assign) MMDrawerAnimationType rightDrawerAnimationType;

+ (HNDrawerVisualStateManager *)sharedManager;

-(MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;
@end
