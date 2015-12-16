//
//  CameraMian.m
//  我爱拍
//
//  Created by Huang Shan on 15/12/6.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "CameraMian.h"
#import "DetectFace.h"
//#import "CameraImageHelper.h"

@interface CameraMian () <DetectFaceDelegate>
@property (strong, nonatomic) DetectFace *detectFaceController;
@property (nonatomic, strong) UIImageView *faceView;
//@property (retain, nonatomic)   UIView *previewView;
//@property (retain, nonatomic)  UIView *switchView;

@end

@implementation CameraMian

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"先支持竖屏识别";
    // 初始化，在这里对吗？
    counter = 0;
    detectionFrequency = 3;
    
    //self是视图控制器，视图控制器的背景颜色
    self.previewView = [[UIView alloc] init];
    self.previewView.backgroundColor = [UIColor greenSeaColor];
    [self.view addSubview:self.previewView];
    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
#if 0
    //新建一个视图控制器类，点击按钮后从本类调转到新建的那个类中，然后再点击一个按钮返回，即从一个view调转到另一个view
    //新建了一个recognizeViewController，继承自ViewController
    //以下是一个按钮，点击后跳转到recognizeViewController的那个视图
    recognitionbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // 设置按钮大小
    int btnRadius = 40;
    recognitionbtn.frame=CGRectMake(self.view.frame.size.width/2-btnRadius, 0.5*self.view.frame.size.height+0.5*previewHeight-btnRadius, 2*btnRadius, 2*btnRadius);
    recognitionbtn.layer.cornerRadius = btnRadius;
    [recognitionbtn setBackgroundColor:[UIColor colorWithRed:73.0/255.0 green:189.0/255.0 blue:204.0/255.0 alpha:1.0]];
    // 设置按钮中字体
    recognitionbtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [recognitionbtn setTitle:@"识别" forState:UIControlStateNormal];
    [recognitionbtn setTintColor:[UIColor whiteColor]];
    // 跳转
    [recognitionbtn addTarget:self action:@selector(startRecognitionButton:) forControlEvents:UIControlEventTouchUpInside];
    // 画出按钮
    [self.view addSubview:recognitionbtn];
    
    // 防止子视图实例化时重复加载
    subvc1 = [[recognizeViewController alloc]init];
#endif
    // 预览图像显示自适应展现
    // 定义View图层
    self.previewView.layer.zPosition = 1;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.detectFaceController = [[DetectFace alloc] init];
    self.detectFaceController.delegate = self;
    self.detectFaceController.previewView = self.previewView;
    cameraState = self.detectFaceController->isFront;
    [self.detectFaceController startDetection];
    [self.view addSubview:self.previewView];
//
   // [self rotateLayer];
}

/*简单的计算，测试版可以先用，量产肯定不行。还没有仔细看API的接口参数。huang shan*/
#define __SIMPLE_ALGORITHM__
#ifdef __SIMPLE_ALGORITHM__
static int count_move[3] = {0};
#endif
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)viewWillUnload
{
    [self.detectFaceController stopDetection];
    [super viewWillUnload];
}
- (void)viewDidUnload {
    [self setPreviewView:nil];
    [super viewDidUnload];
}


- (void)detectedFaceController:(DetectFace *)controller features:(NSArray *)featuresArray forVideoBox:(CGRect)clap withPreviewBox:(CGRect)previewBox
{
    // 防止每帧图像都计算人脸检测，导致手机过热
    if(counter < detectionFrequency){
        counter += 1;
        return;
    }
    counter = 0;
    
    if (!self.faceView){
        self.faceView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100,100,100)];
        self.faceView.contentMode = UIViewContentModeScaleToFill;
        [self.previewView addSubview:self.faceView];
       // cameraState = self.detectFaceController->isFront;
    }
    self.faceView.layer.borderWidth = 0;
    [recognitionbtn setEnabled:false];
    
    
    for (CIFaceFeature *ff in featuresArray) {
        // find the correct position for the square layer within the previewLayer
        // the feature box originates in the bottom left of the video frame.
        // (Bottom right if mirroring is turned on)
        realfaceRect = [ff bounds];///////////////
#ifdef __SIMPLE_ALGORITHM__
        if ([featuresArray count] == 1)
        {
            if(count_move[0] == 0)
            {
                count_move[0] = realfaceRect.origin.x;
            }
            else if(count_move[1] == 0)
            {
                count_move[1] = realfaceRect.origin.x;
            }
            else if(count_move[2] == 0)
            {
                count_move[2] = realfaceRect.origin.x;
            }
            else
            {
                count_move[0] = 0;
                count_move[1] = 0;
                count_move[2] = 0;
                count_move[0] = realfaceRect.origin.x;
            }
            if ((count_move[2] != 0)&&(count_move[1] != 0)&&(count_move[0] != 0)) {
                if ((count_move[2]>count_move[1])&&(count_move[1]>count_move[0]))
                {
                    if (self.deviceDelgate&&[self.deviceDelgate respondsToSelector:@selector(deviceShouldTurnRight)]) {
                        [self.deviceDelgate deviceShouldTurnRight];
                    }
                }
                else if ((count_move[2]<count_move[1])&&(count_move[1]<count_move[0]))
                {
                    if (self.deviceDelgate&&[self.deviceDelgate respondsToSelector:@selector(deviceShouldTurnLeft)]) {
                        [self.deviceDelgate deviceShouldTurnLeft];
                    }
                }

            }
        }
#endif
        if (self.detectFaceController->isFront == 1)
            faceRect = [DetectFace convertFrame:realfaceRect previewBox:previewBox forVideoBox:clap isMirrored:NO];
        else
            faceRect = [DetectFace convertFrame:realfaceRect previewBox:previewBox forVideoBox:clap isMirrored:YES];
        
        self.faceView.layer.borderWidth = 1;
        [recognitionbtn setEnabled:true];
        self.faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        
        float face_width = faceRect.size.width;
        float face_height = faceRect.size.height;
        float face_y = faceRect.origin.y;
        float face_x = faceRect.origin.x;
        
        [self.faceView setFrame:CGRectMake(face_x, face_y, face_width, face_height)];
    }
}

//等比例缩放
- (UIImage *)scalingImage:(UIImage *)image {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    
    CGSize newSize;
    newSize.width = self.view.frame.size.width;
    newSize.height = newSize.width * 4/3;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

- (UIImage *)imageRotatedByDegrees:(UIImage*)image
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(90));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(90));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    UIDeviceOrientation orientation =[[UIDevice currentDevice] orientation];
    [self.navigationController setNavigationBarHidden:UIDeviceOrientationIsLandscape(orientation) animated:YES];
    [self.detectFaceController changePreviewOrientation:(UIInterfaceOrientation)orientation];


}

@end
