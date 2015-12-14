//
//  CameraMian.h
//  我爱拍
//
//  Created by Huang Shan on 15/12/6.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HNHomePageController.h"
@protocol deviceShouldRotationDelegate <NSObject>

-(void)deviceShouldTurnRight;

-(void)deviceShouldTurnLeft;
@end

@interface CameraMian : UIViewController
{
    // 记录前视摄像头or后视摄像头
    int cameraState;
    // 人脸检测频率
    int detectionFrequency;
    // 记录帧数量
    int counter;
    
@public
    // 选择的图像
    UIImage* pickedImage;
    
    UIButton *recognitionbtn;
    CGRect faceRect;
    CGRect realfaceRect;
}
- (UIImage *)imageRotatedByDegrees:(UIImage*)image;
@property (weak, nonatomic) IBOutlet UIView *switchView;
@property (weak, nonatomic) IBOutlet UIView *previewView;

@property (weak, nonatomic) id<deviceShouldRotationDelegate> deviceDelgate;
@end
