//
//  UMSocialSnsService+wufang.h
//  education
//
//  Created by 五方科技 on 15/11/24.
//  Copyright © 2015年 zhujun. All rights reserved.
//

#import "UMSocialSnsService.h"

@interface UMSocialSnsService (wufang)
/**
 *  分享
 *
 *  @param controller         呈现分享界面的controller
 *  @param shareText           分享的文字
 *  @param shareUrl            分享的url
 *  @param shareImageUrlString 分享的图片
 */
+(void)presentSnsIconSheetView:(UIViewController *)controller
                     shareText:(NSString*)shareText
                      shareUrl:(NSString*)shareUrl
                    shareImage:(NSString*)shareImageUrlString;
@end
