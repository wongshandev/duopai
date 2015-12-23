//
//  UMSocialSnsService+wufang.m
//  education
//
//  Created by 五方科技 on 15/11/24.
//  Copyright © 2015年 zhujun. All rights reserved.
//

#import "UMSocialSnsService+wufang.h"

@implementation UMSocialSnsService (wufang)
+(void)presentSnsIconSheetView:(UIViewController *)controller
                     shareText:(NSString*)shareText
                      shareUrl:(NSString*)shareUrl
                    shareImage:(NSString*)shareImageUrlString{
    UMSocialUrlResource* resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:shareImageUrlString];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareUrl;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = resource;
    [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = resource ;
    [UMSocialData defaultData].extConfig.qqData.urlResource = resource;
    [UMSocialData defaultData].extConfig.qzoneData.urlResource = resource ;
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:UMENG_APPKEY
                                      shareText:shareText
                                     shareImage:[UIImage imageNamed:@"app_icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:nil];
}
@end
