//
//  HNPickerViewController.h
//  朵拍
//
//  Created by lilin on 15/12/5.
//  Copyright © 2015年 lilin. All rights reserved.
//

#import "HNTableViewController.h"
typedef NS_ENUM(NSInteger, HNPickerType){
    HNPickerTypePhoto,//
    HNPickerTypeVideo,
    HNPickerTypeCountFace,//
    HNPickerTypeCountTelControl,
};
@interface HNPickerViewController : HNTableViewController
+(HNPickerViewController*)pickerWithPickeType:(HNPickerType)picktype
                                     pickList:(NSArray*)list
                                completeBlock:(void (^)(NSString* pickerString))completeBlock;

@end
