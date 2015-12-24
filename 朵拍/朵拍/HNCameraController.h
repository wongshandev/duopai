//
//  HNCameraController.h
//  朵拍
//
//  Created by 五方科技 on 15/12/15.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class CIDetector;
@protocol HNDeviceShouldRotationDelegate <NSObject>

-(void)deviceShouldTurnRight;

-(void)deviceShouldTurnLeft;
@end

@interface HNCameraController : UIViewController <UIGestureRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>
{
    BOOL canSnaped;
    /*人脸是否在中央*/
    BOOL IsFaceInCenter;
}

@property(nonatomic,strong)UIView *previewView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *segment;
@property (weak, nonatomic) IBOutlet UISwitch *facedetect;
@property (weak, nonatomic) id<HNDeviceShouldRotationDelegate> deviceDelgate;
@end
