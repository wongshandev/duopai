//
//  CameraImageHelper.h
//  HelloWorld
//
//  Created by Erica Sadun on 7/21/10.
//  Copyright 2010 Up To No Good, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol AVHelperDelegate;

@interface CameraImageHelper : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>
{
	AVCaptureSession *session;
	UIImage *image;
    AVCaptureStillImageOutput *captureOutput;
    UIImageOrientation g_orientation;
    AVCaptureVideoDataOutput *videoDataOutput;
    dispatch_queue_t videoDataOutputQueue;
    int isFront;

}
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureStillImageOutput *captureOutput;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign) UIImageOrientation g_orientation;
@property (nonatomic,assign) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic,assign) id<AVHelperDelegate>delegate;

// 人脸检测
@property (nonatomic, strong) CIDetector * faceDetector;

- (void) startRunning;
- (void) stopRunning;

-(void)setDelegate:(id<AVHelperDelegate>)_delegate;
-(void)CaptureStillImage;
- (void)embedPreviewInView: (UIView *) aView;
- (void)changePreviewOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end

@protocol AVHelperDelegate <NSObject>

-(void)didFinishedCapture:(UIImage*)_img;
-(void)foucusStatus:(BOOL)isadjusting;

- (void)detectedFaceController:(CameraImageHelper *)controller features:(NSArray *)featuresArray forVideoBox:(CGRect)clap withPreviewBox:(CGRect)previewBox;
@end
