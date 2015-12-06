//
//  UIScrollView+Parallax.h
//  TableViewSearchBar
//
//  Created by 林 李 on 8/29/14.
//  Copyright (c) 2014 Fabian Kreiser. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNParallaxShadowView;
@class HNParallaxView;
@protocol HNParallaxViewDelegate;

typedef NS_ENUM(NSUInteger, HNParallaxTrackingState) {
    HNParallaxTrackingActive = 0,
    HNParallaxTrackingInactive
};

@interface UIScrollView (Parallax)
- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height andShadow:(BOOL)shadow;
- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height andShadow:(BOOL)shadow ;
-(void)changeParallaxHeight:(CGFloat)height;
//视差视图
@property (nonatomic, strong, readonly) HNParallaxView *parallaxView;

//是否显示视差
@property (nonatomic, assign) BOOL showsParallax;
@end


#pragma mark APParallaxShadowView

@interface HNParallaxShadowView : UIView

@end

@interface HNParallaxView : UIView
//当前视差状态是否开启
@property (nonatomic, readonly) HNParallaxTrackingState state;

@property (nonatomic, strong) UIImageView *imageView;

//当前子视图
@property (nonatomic, strong) UIView *currentSubView;

//阴影视图
@property (nonatomic, strong) HNParallaxShadowView *shadowView;

@property (weak) id<HNParallaxViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andShadow:(BOOL)shadow;
@end

@protocol HNParallaxViewDelegate <NSObject>
@optional
- (void)parallaxView:(HNParallaxView *)view willChangeFrame:(CGRect)frame;
- (void)parallaxView:(HNParallaxView *)view didChangeFrame:(CGRect)frame;
@end