//
//  UIColor+utils.m
//  luckytree
//
//  Created by 林 李 on 6/30/14.
//  Copyright (c) 2014 cnhnb. All rights reserved.
//

#import "UIColor+utils.h"

@implementation UIColor (utils)
// Thanks to http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *) colorWithHexString:(NSString*)hexString{
    return [self colorFromHexCode:hexString];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *) turquoiseColor {
    return [UIColor colorFromHexCode:@"1ABC9C"];
}

+ (UIColor *) greenSeaColor {
    return [UIColor colorFromHexCode:@"16A085"];
}

+ (UIColor *) emerlandColor {
    return [UIColor colorFromHexCode:@"2ECC71"];
}

+ (UIColor *) nephritisColor {
    return [UIColor colorFromHexCode:@"27AE60"];
}

+ (UIColor *) peterRiverColor {
    return [UIColor colorFromHexCode:@"3498DB"];
}

+ (UIColor *) belizeHoleColor {
    return [UIColor colorFromHexCode:@"2980B9"];
}

+ (UIColor *) amethystColor {
    return [UIColor colorFromHexCode:@"9B59B6"];
}

+ (UIColor *) wisteriaColor {
    return [UIColor colorFromHexCode:@"8E44AD"];
}

+ (UIColor *) wetAsphaltColor {
    return [UIColor colorFromHexCode:@"34495E"];
}

+ (UIColor *) midnightBlueColor {
    return [UIColor colorFromHexCode:@"2C3E50"];
}

+ (UIColor *) sunflowerColor {
    return [UIColor colorFromHexCode:@"F1C40F"];
}

+ (UIColor *) tangerineColor {
    return [UIColor colorFromHexCode:@"F39C12"];
}

+ (UIColor *) carrotColor {
    return [UIColor colorFromHexCode:@"E67E22"];
}

+ (UIColor *) pumpkinColor {
    return [UIColor colorFromHexCode:@"D35400"];
}

+ (UIColor *) alizarinColor {
    return [UIColor colorFromHexCode:@"E74C3C"];
}

+ (UIColor *) pomegranateColor {
    return [UIColor colorFromHexCode:@"C0392B"];
}

+ (UIColor *) cloudsColor {
    return [UIColor colorFromHexCode:@"ECF0F1"];
}

+ (UIColor *) silverColor {
    return [UIColor colorFromHexCode:@"BDC3C7"];
}

+ (UIColor *) concreteColor {
    return [UIColor colorFromHexCode:@"95A5A6"];
}

+ (UIColor *) asbestosColor {
    return [UIColor colorFromHexCode:@"7F8C8D"];
}

+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend {
    CGFloat onRed, offRed, newRed, onGreen, offGreen, newGreen, onBlue, offBlue, newBlue, onWhite, offWhite;
    if ([foregroundColor getWhite:&onWhite alpha:nil]) {
        onRed = onWhite;
        onBlue = onWhite;
        onGreen = onWhite;
    }
    else {
        [foregroundColor getRed:&onRed green:&onGreen blue:&onBlue alpha:nil];
    }
    if ([backgroundColor getWhite:&offWhite alpha:nil]) {
        offRed = offWhite;
        offBlue = offWhite;
        offGreen = offWhite;
    }
    else {
        [backgroundColor getRed:&offRed green:&offGreen blue:&offBlue alpha:nil];
    }
    newRed = onRed * percentBlend + offRed * (1-percentBlend);
    newGreen = onGreen * percentBlend + offGreen * (1-percentBlend);
    newBlue = onBlue * percentBlend + offBlue * (1-percentBlend);
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
}

+ (UIColor *) navgaitionBarTintColor
{
    return [UIColor colorFromHexCode:@"FF7C06"];
}

+ (UIColor *)baseViewControllerColor{
    return [UIColor colorFromHexCode:@"fafafa"];
}

+ (UIColor *) navgaitionTintColor
{
    return [UIColor colorFromHexCode:@"ffffff"];
}

+ (UIColor *) navgaitionBottomLineColor
{
    return [UIColor colorFromHexCode:@"d23046"];
}

+ (UIColor *) myNavgaitionBarTintColor
{
    return [UIColor colorFromHexCode:@"BF1E28"];
}


+ (UIColor *)placeholderColor
{
    return [UIColor colorFromHexCode:@"999999"];
}

+(UIColor *)loginContentColor
{
    return [UIColor colorFromHexCode:@"666666"];
}

+ (UIColor *) tabBarTintColor
{
    return [UIColor colorFromHexCode:@"f26b09"];
}

+ (UIColor *) seperateColor
{
    return [UIColor colorFromHexCode:@"dcdcdc"];
}

+ (UIColor *) tableBackgroundColor
{
    return [UIColor colorFromHexCode:@"efeeeb"];
}

+(UIColor*)tableSysSeperateColor
{
    return [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1];
}

+(UIColor*)tableAppSeperateColor
{
    return [UIColor colorFromHexCode:@"c9c9d8"];
}

+(UIColor*)tableTitleNormalColor
{
     return [UIColor colorFromHexCode:@"3e3e3e"];
}

+(UIColor*)tableTitleHighlightColor
{
    return [UIColor colorFromHexCode:@"8a8a8a"];
}

+(UIColor*)textFieldBorderColor
{
    return [UIColor colorFromHexCode:@"bdbdcb"];
}

+ (UIColor *) buttonNormalBackgroundColor
{
    return [UIColor colorFromHexCode:@"ebebf3"];
}

+ (UIColor *) buttonNormalBoderColor
{
    return [UIColor colorFromHexCode:@"cbcbcb"];
}

+ (UIColor *) loadingBackgroundColor
{
    return [UIColor whiteColor];
}

+ (UIColor *) loadingTextColor
{
    return [UIColor colorFromHexCode:@"fa5867"];
}

+ (UIColor *) lineColor{
    return [UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:1.0];
}

+ (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}

@end
