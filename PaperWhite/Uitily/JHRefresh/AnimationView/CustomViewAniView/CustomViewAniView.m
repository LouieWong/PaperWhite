//
//  LouieWongloadingView.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/8.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "CustomViewAniView.h"
#import "UIView+JHExtension.h"
#import "JHRefreshMacro.h"
@implementation CustomViewAniView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _aniImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading000.png"]];
        _aniImgView.frame = CGRectMake(0, 0, 100, 20);
        _aniImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_aniImgView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _aniImgView.center = CGPointMake(self.jh_width*0.5, self.jh_height*0.5);
}


/**
*  下拉时的动画
*/
- (void)refreshViewAniToBePulling
{
    
}
/**
 *  变成普通状态时的动画
 */
- (void)refreshViewAniToBeNormal
{
    [_aniImgView stopAnimating];

}
/**
 *  刷新开始
 */
- (void)refreshViewBeginRefreshing
{
    if(!_aniImgView.animationImages)
    {
        NSMutableArray *animationArrays = [NSMutableArray array];
        for (NSInteger i=0 ;i<21;i++)
        {
            [animationArrays addObject:[UIImage imageNamed:[NSString stringWithFormat: @"loading%03ld.png",i]]];
        }
        _aniImgView.animationImages = animationArrays;
        _aniImgView.animationDuration = 1.0;
        _aniImgView.animationRepeatCount = 0;
    }
    
    //刷新开始时，设置aniImageView的宽高
//    _aniImgView.jh_width = 
//    _aniImgView.jh_height = JHRefreshViewHeight;
    [_aniImgView startAnimating];
}
/**
 *  刷新结束
 *
 *  @param result 刷新结果
 */
- (void)refreshViewEndRefreshing:(JHRefreshResult)result{
    
}

@end
