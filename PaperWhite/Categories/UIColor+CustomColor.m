//
//  UIColor+CustomColor.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/24.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+(UIColor *)backGrayColor
{
    return [self colorWithRed:213 green:213 blue:213];
}
+(UIColor *)deepBlackColor
{
    return [self colorWithRed:5 green:5 blue:5];
}
+(UIColor *)customGrayColor
{
    return [self colorWithRed:40 green:40 blue:40];
}

+(UIColor *)orangeYellowColor
{
    return [self colorWithRed:137 green:191 blue:0];
}
+(UIColor *)cyanGreenColor
{
    return [self colorWithRed:0 green:129 blue:114];
}
+(UIColor *)randomcolor
{
    return [self colorWithRed:arc4random()%256 green:arc4random()%256 blue:arc4random()%256];
}
#pragma mark - Private class methods

+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:1.f];
}

@end
