//
//  NewsCell.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "NewsCell.h"
#import "Masonry.h"
#import <POP.h>
@implementation NewsCell

- (void)awakeFromNib {
    self.titleImage.layer.cornerRadius=3.0;
    self.titleImage.layer.masksToBounds=YES;
    self.titleImage.contentMode = UIViewContentModeScaleAspectFill;
    self.titleImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.titleImage.clipsToBounds  = YES;
    self.backView.layer.cornerRadius = 5.0;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.title.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:18];
    self.contents.font = [UIFont fontWithName:@"Avenir-Medium"
                                      size:14];
    self.contents.textColor = [UIColor customGrayColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)updateModel:(PianKeMainModel*)model
{
    if (model.coverimg == nil) {
        self.titleImage.hidden = YES;
        self.TitleConstraint.constant = 10;
    }else{
        [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"Placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        }];
    }
    
    self.title.text = model.title;
    self.contents.text = model.content;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
////            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
////            scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
////            scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(1,1)];
////            scaleAnimation.springBounciness = 10.f;
////            scaleAnimation.springSpeed = 20.f;
//////            [self.title pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//////            [self.titleImage pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
////            [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//        
     
//            [self scaleAnimation];
//        
        } else {
//               [self shake];
////            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
////            scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//////            scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(0.1, 0.1)];
//////            scaleAnimation.springBounciness = 20.f;
////////            [self.title pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
////////            [self.titleImage pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
////            [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//            [self scaleToDefault];
//            [self dissolve];
//            [self scaleToSmall];
//            [self scaleAnimation];
//            [self scaleToDefault];
//            [self test1];
        
        }
//
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
////    [self scaleToSmall];
////    [self scaleAnimation];
////    [self scaleToDefault];
////    [self scaleToSmall];
////    [self left];
////    [self test1];
//    
//}
- (void)test1
{
    POPBasicAnimation *test1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    test1.duration = 0.5f;
    test1.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    test1.fromValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    [self.layer pop_addAnimation:test1 forKey:@"test1"];
    
}
- (void)test2
{
    
}
- (void)appear
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    scaleAnimation.springBounciness = 20.f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];

}
- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}
- (void)dissolve
{
    POPBasicAnimation *dissolve = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    dissolve.fromValue = @(0);
    dissolve.toValue = @(1);
    dissolve.duration = 1.0f;
    [self pop_addAnimation:dissolve forKey:@"dissolve"];
}

- (void)scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}
- (void)shake
{
    [self.layer pop_removeAllAnimations];
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.velocity = @100;
    positionAnimation.springBounciness = 20;
//    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finshed) {
//        if (finshed) {
//            [self shake];
//        }
//    }];
    [self.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];

}

- (void)left
{
//    POPDecayAnimation *anm = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//    anm.velocity = @(1500);
    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.velocity = @(100);
//    anim.fromValue = @(25.0);
    [self.layer pop_addAnimation:anim forKey:@"anim"];
}
@end
