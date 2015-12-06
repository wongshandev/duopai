//
//  HNTabBar.m
//  luckytree
//
//  Created by lilin on 14-4-29.
//  Copyright (c) 2014年 cnhnb. All rights reserved.
//

#import "HNTabBar.h"
//#import "UIImage+utils.h"

#define CenterButtonWidth 74.
#define SideButtonWidth ((SCREEN_WIDTH - 74)/2.)

//#define before 1

@protocol HNTabBarItemDelegate<NSObject>
-(void)didSelectedTabbarItem:(HNTabBarItem*)tabbarItem;
@end
@interface HNTabBarItem ()
@property(nonatomic,weak)id<HNTabBarItemDelegate> delegate;
@property(nonatomic,strong)UIButton* tabButton;
@property(nonatomic,strong)UIImageView* tabImageView;
@property(nonatomic,strong)UILabel* tabLabel;
@property(nonatomic,strong)UIImage* normalImage;
@property(nonatomic,strong)UIImage* selectImage;
@property(nonatomic,strong)UIImage* normalBackGroundImage;
@property(nonatomic,strong)UIImage* selectBackGroundImage;
@property(nonatomic,assign)BOOL selected;

@property(nonatomic,strong)UIColor* selectColor;
@property(nonatomic,strong)UIColor* normalColor;
@end

@implementation HNTabBarItem
@synthesize selected = _selected;
-(void)itemDidSelect:(UIButton*)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTabbarItem:)]) {
        [self.delegate didSelectedTabbarItem:self];
    }
}

-(void)setUP{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(itemDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.tabButton = btn;
    
    UILabel* label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    self.tabLabel = label;
    
    UIImageView* iv = [[UIImageView alloc] init];
    [self addSubview:iv];
    self.tabImageView = iv;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame iconName:(NSString*)imageName title:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
        self.tabImageView.image = [UIImage imageNamed:imageName];
        self.tabLabel.text = title;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    self.tabLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    self.tabImageView.frame = CGRectMake((self.frame.size.width - 26)/2, (self.frame.size.height - 20 - 26)/2 + 2, 26, 26);
    self.tabButton.frame = self.bounds;
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super init];
    if (self) {
        [self setUP];
        //别的
//        self.selectImage = selectedImage;
//        self.normalImage = image;
//        self.tabImageView.image = image;
//        self.tabLabel.text = title;
        //wufang
        self.normalBackGroundImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
        self.selectBackGroundImage = [selectedImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 1, 0, 1)];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    self = [super init];
    if (self) {
        [self setUP];
        //别的
        //        self.selectImage = selectedImage;
        //        self.normalImage = image;
        //        self.tabImageView.image = image;
        //        self.tabLabel.text = title;
        //wufang
        self.normalBackGroundImage = [UIImage imageNamed:imageName] ;
        self.selectBackGroundImage = [UIImage imageNamed:selectedImageName];
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    self.tabImageView.image = _selected ? self.selectImage : self.normalImage;
    self.tabLabel.textColor = _selected ? self.selectColor : self.normalColor;
    [self.tabButton setBackgroundImage:_selected ? self.selectBackGroundImage : self.normalBackGroundImage
                              forState:UIControlStateNormal];
#ifdef before
        [self.tabButton setBackgroundImage:_selected ? _selectBackGroundImage : _normalBackGroundImage forState:UIControlStateNormal];
        [self.tabButton setBackgroundImage:_selected ? _selectBackGroundImage : _normalBackGroundImage forState:UIControlStateHighlighted];
#else
    
#endif
}

-(BOOL)selected
{
    return _selected;
}
@end

@interface HNTabBar ()<HNTabBarItemDelegate>
@property(nonatomic,strong)NSMutableArray* tabbarItemArray;
@end

@implementation HNTabBar
@synthesize selectedIndex = _selectedIndex;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
#ifdef before
        self.normaltintColor = [UIColor whiteColor];

#else
        self.normaltintColor = [UIColor blackColor];

#endif
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
#ifdef before
        NSArray* titleArray = @[@"首页",@"通讯录",@"我的",@"设置"];
        NSArray* imageArray = @[[UIImage imageNamed:@"nav1"],
                                [UIImage imageNamed:@"nav2"],
                                [UIImage imageNamed:@"nav3"],
                                [UIImage imageNamed:@"nav4"]];
    
        NSArray* imageselectArray = @[[UIImage imageNamed:@"nav1p"],
                                      [UIImage imageNamed:@"nav2p"],
                                      [UIImage imageNamed:@"nav3p"],
                                      [UIImage imageNamed:@"nav4p"]];
#else

    
    
    NSArray* titleArray = @[@"首页",@"通讯录",@"我的",@"设置"];
    NSArray* imageArray;/*= @[[UIImage imageNamed:@"n1"],
                            [UIImage imageNamed:@"n2"],
                            [UIImage imageNamed:@"n3"],
                            [UIImage imageNamed:@"n4"]];*/
    NSArray* imageselectArray ;/*= @[[UIImage imageNamed:@"n1_1"],
                                  [UIImage imageNamed:@"n2_1"],
                                  [UIImage imageNamed:@"n3_1"],
                                  [UIImage imageNamed:@"n4_1"]];*/

    imageArray = @[@"homePage_un",@"contactIndex_un",@"userCenter_un",@"setting_un"];
    imageselectArray = @[@"homePage",@"contactIndex",@"userCenter",@"setting"];

#endif
    for (int i = 0; i< 4; i++) {
        HNTabBarItem* item = [[HNTabBarItem alloc] initWithTitle:titleArray[i] imageName:imageArray[i] selectedImageName:imageselectArray[i]];
        item.delegate = self;
        item.tag = i;
        item.selectColor = self.tintColor;
        item.normalColor = self.normaltintColor;
        item.frame = CGRectMake(self.frame.size.width/4. * i, 0, self.frame.size.width/4., self.frame.size.height);
        item.selected = self.selectedIndex == i;
        [self addSubview:item];
    }
    
}

-(void)setBarTintColor:(UIColor *)barTintColor
{
    _barTintColor = barTintColor;
    self.backgroundColor = self.barTintColor;
}

-(void)didSelectedTabbarItem:(HNTabBarItem *)tabbarItem
{
    NSArray* tabItemArray = self.subviews;
    for (HNTabBarItem* item in tabItemArray) {
        item.selected = (item == tabbarItem);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:tabbarItem.tag];
    }
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    NSArray* tabItemArray = self.subviews;
    for (HNTabBarItem* item in tabItemArray) {
        item.selected = (item.tag == selectedIndex);
    }

}

-(NSUInteger)selectedIndex
{
    return _selectedIndex;
}
@end
