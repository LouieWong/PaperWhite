//
//  UIImage+Blur.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/10.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
@interface UIImage (Blur)

// 0.0 to 1.0
+ (UIImage*)setBlurImage:(UIImage*)image quality:(float)quality blurred:(float)blurrred;

@end
