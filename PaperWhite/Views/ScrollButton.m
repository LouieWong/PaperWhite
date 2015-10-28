//
//  ScrollButton.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/28.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "ScrollButton.h"
#import <UIImageView+WebCache.h>
#import <POP.h>
@implementation ScrollButton

+ (instancetype)buttonWithName:(NSString*)name image:(UIImage*)image

{
    return [[self alloc]initWithFrame:CGRectZero Name:name image:image];
}

//+ (instancetype)buttonWithOrigin:(CGPoint)origin
//{
//    return [[self alloc] initWithFrame:CGRectMake(origin.x,
//                                                  origin.y,
//                                                  24,
//                                                  17)];
//}

- (id)initWithFrame:(CGRect)frame Name:(NSString*)name image:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{

}
//- (void)setSelected:(BOOL)selected
//{
//    if (selected) {
//        [self buttonAnimation1];
//    }else{
//        [self buttonAnimation1];
//    }
//    
//}
- (void)buttonAnimation1
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    CGPoint point = self.center;
    float tmp = self.bounds.size.height;
    NSLog(@"tmp%f",tmp);
    if (point.y<tmp) {
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x, -50)];
    } else{
        springAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(point.x, 100)]; }
    springAnimation.springBounciness = 20.0; //弹性速度 springAnimation.springSpeed = 20.0;
    [self.layer pop_addAnimation:springAnimation forKey:@"springAnimation"];
}
@end
