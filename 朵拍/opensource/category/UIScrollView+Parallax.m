//
//  UIScrollView+Parallax.m
//  TableViewSearchBar
//
//  Created by 林 李 on 8/29/14.
//  Copyright (c) 2014 Fabian Kreiser. All rights reserved.
//

#import "UIScrollView+Parallax.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UIColor+utils.h"
@interface HNParallaxView ()

@property (nonatomic, readwrite) HNParallaxTrackingState state;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) CGFloat originalTopInset;
@property (nonatomic) CGFloat parallaxHeight;//视察高度
@property(nonatomic, assign) BOOL isObserving;

@end

@implementation UIScrollView (Parallax)
static const void *UIScrollViewParallaxViewKey = &UIScrollViewParallaxViewKey;
#pragma mark - 设置属性
- (void)setParallaxView:(HNParallaxView *)parallaxView {
    objc_setAssociatedObject(self, UIScrollViewParallaxViewKey,  parallaxView, OBJC_ASSOCIATION_ASSIGN);
}

- (HNParallaxView *)parallaxView {
    return objc_getAssociatedObject(self,UIScrollViewParallaxViewKey);
}

- (void)setShowsParallax:(BOOL)showsParallax {
    self.parallaxView.hidden = !showsParallax;
    if(!showsParallax) {
        if (self.parallaxView.isObserving) {
            [self removeObserver:self.parallaxView forKeyPath:@"contentOffset"];
            [self removeObserver:self.parallaxView forKeyPath:@"frame"];
            self.parallaxView.isObserving = NO;
        }
    }else {
        if (!self.parallaxView.isObserving) {
            [self addObserver:self.parallaxView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.parallaxView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            self.parallaxView.isObserving = YES;
        }
    }
}

- (BOOL)showsParallax {
    return !self.parallaxView.hidden;
}

- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height {
    [self addParallaxWithImage:image andHeight:height andShadow:YES];
}

- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height andShadow:(BOOL)shadow {
    if(self.parallaxView) {
        if(self.parallaxView.currentSubView) {
            [self.parallaxView.currentSubView removeFromSuperview];
        }
        [self.parallaxView.imageView setImage:image];
    }
    else
    {
        HNParallaxView *view = [[HNParallaxView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height) andShadow:shadow];
        [view setClipsToBounds:YES];
        [view.imageView setImage:image];
        
        view.scrollView = self;
        view.parallaxHeight = height;
        [self addSubview:view];
        
        view.originalTopInset = self.contentInset.top;
        
        UIEdgeInsets newInset = self.contentInset;
        newInset.top = height;
        self.contentInset = newInset;
        
        self.parallaxView = view;
        self.showsParallax = YES;
    }
}

- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height {
    [self addParallaxWithView:view andHeight:height andShadow:YES];
}


-(void)changeParallaxHeight:(CGFloat)height{
//    UIEdgeInsets newInset = self.contentInset;
//    newInset.top = height;
//    self.contentInset = newInset;
//    
//    CGPoint p = self.contentOffset;
//    p.y = -height;
//    [UIView animateWithDuration:0.7 animations:^{
//        self.contentOffset = p;
//    }];
    
    self.parallaxView.frame = CGRectMake(0, 0, self.bounds.size.width, height);

}

- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height andShadow:(BOOL)shadow {
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    if(self.parallaxView) {
        
        UIEdgeInsets newInset = self.contentInset;
        newInset.top = height;
        self.contentInset = newInset;
        
        CGPoint p = self.contentOffset;
        p.y = -height;
        [UIView animateWithDuration:0.7 animations:^{
            self.contentOffset = p;
        }];
        
        self.parallaxView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
        [self.parallaxView.currentSubView removeFromSuperview];
        [self.parallaxView addSubview:view];
    }else{
        HNParallaxView *parallaxView = [[HNParallaxView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height) andShadow:shadow];
        //[parallaxView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        parallaxView.backgroundColor = [UIColor greenSeaColor];
        parallaxView.clipsToBounds = YES;
        parallaxView.originalTopInset = self.contentInset.top;
        parallaxView.scrollView = self;
        parallaxView.parallaxHeight = height;
        [parallaxView addSubview:view];
        [self addSubview:parallaxView];
        
        UIEdgeInsets newInset = self.contentInset;
        newInset.top = height;
        self.contentInset = newInset;
        
        self.parallaxView = parallaxView;
        self.showsParallax = YES;
    }
}

@end

#pragma mark - HNParallaxView
static int const defaultShadowHeight = 8;
@implementation HNParallaxView
- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame andShadow:YES];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andShadow:(BOOL)shadow
{
    self = [super initWithFrame:frame];
    if(self) {
    
        // default styling values
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self setState:HNParallaxTrackingActive];
        [self setAutoresizesSubviews:YES];
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setClipsToBounds:YES];
        [self addSubview:self.imageView];
        
        if (shadow) {
            self.shadowView = [[HNParallaxShadowView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(frame) - defaultShadowHeight, CGRectGetWidth(frame), defaultShadowHeight)];
            [self.shadowView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
            [self addSubview:self.shadowView];
        }
    }
    return self;
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    self.currentSubView = view;
}

//取消监听
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.superview && newSuperview == nil) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        if (scrollView.showsParallax) {
            if (self.isObserving) {
                [scrollView removeObserver:self forKeyPath:@"contentOffset"];
                [scrollView removeObserver:self forKeyPath:@"frame"];
                self.isObserving = NO;
            }
        }
    }else{
        if (self.shadowView) {
            [self bringSubviewToFront:self.shadowView];
        }
    }
    
}
#pragma mark - Observing
#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }else if([keyPath isEqualToString:@"frame"]){
        [self layoutSubviews];
    }
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset {
    // We do not want to track when the parallax view is hidden
    if (contentOffset.y > 0) {
        [self setState:HNParallaxTrackingInactive];
    } else {
        [self setState:HNParallaxTrackingActive];
    }
    
    if(self.state == HNParallaxTrackingActive) {
        CGFloat yOffset = contentOffset.y * -1;
        if ([self.delegate respondsToSelector:@selector(parallaxView:willChangeFrame:)]) {
            [self.delegate parallaxView:self willChangeFrame:self.frame];
        }

        [self setFrame:CGRectMake(0, contentOffset.y, CGRectGetWidth(self.frame), yOffset)];
        
        UIView* v = [self viewWithTag:101];
        CGRect rect = v.frame;
        rect.origin.y = (contentOffset.y * -1) - rect.size.height;
        v.frame =rect;
        
        if ([self.delegate respondsToSelector:@selector(parallaxView:didChangeFrame:)]) {
            [self.delegate parallaxView:self didChangeFrame:self.frame];
        }
    }
}
@end

#pragma mark - ShadowLayer
@implementation HNParallaxShadowView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];//设置为透明
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    ////通用的声明
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// 渐变的声明
    NSArray* gradient3Colors = [NSArray arrayWithObjects: (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor, (id)[UIColor clearColor].CGColor, nil];
    CGFloat gradient3Locations[] = {0, 1};
    CGGradientRef gradient3 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient3Colors, gradient3Locations);
    
    //// 区域绘制渐变
    CGContextSaveGState(context);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(rect), 8)];
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient3, CGPointMake(0, CGRectGetHeight(rect)), CGPointMake(0, 0), 0);
    CGContextRestoreGState(context);
    
    //// Cleanup
    CGGradientRelease(gradient3);
    CGColorSpaceRelease(colorSpace);
    
}
@end