//
//  DetailWebView.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/27.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "DetailWebView.h"
#import <POP.h>
@interface DetailWebView ()
- (void)setup;
@property (nonatomic)UIWebView *UIWebView;
@end

@implementation DetailWebView
+ (instancetype)UIWebView
{
    return [self UIWebViewWithOrigin:CGPointZero];
}
+ (instancetype)UIWebViewWithOrigin:(CGPoint)origin
{
    return [[self alloc]initWithFrame:CGRectMake(0,
                                                 0,
                                                 origin.x,
                                                 origin.y)];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
#pragma mark - UIWebView
- (void)setup
{
//    [self fadeInView];
    [self slideInView];
}
- (void)fadeInView
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    scaleAnimation.fromValue = @(self.layer.position.y/3);
    scaleAnimation.toValue = @(self.frame.size.height);
    [scaleAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finshed) {
        if (finshed) {
            [self slideInView];
        }
    }];
    scaleAnimation.springBounciness = 10;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation1"];
                            
}
- (void)slideInView
{
    POPSpringAnimation *scaleAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY]; scaleAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
        scaleAnimation1.springBounciness = 10.f;
    [scaleAnimation1 setCompletionBlock:^(POPAnimation *anim, BOOL finshed) {
        if (finshed) {
            [self blowUp];

        }
    }];
    [self.layer pop_addAnimation:scaleAnimation1 forKey:@"layerScaleSmallAnimation1"];
    

}
- (void)blowUp
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
