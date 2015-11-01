//
//  NewCell.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/27.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "PianKeListCell.h"
#import "NetDataEngine.h"

@implementation PianKeListCell

- (void)awakeFromNib {
    self.backView.layer.cornerRadius = 6.0;
    self.backView.contentMode = UIViewContentModeScaleAspectFill;
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.backView.clipsToBounds  = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    self.Contents.font = [UIFont fontWithName:@"Avenir-Medium"
                                         size:14];
    self.Title.font = [UIFont fontWithName:@"Avenir-Medium"
                                         size:20];
}
- (void)updateModel:(PianKeMainModel*)pianKeMainModel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.indexImageView sd_setImageWithURL:[NSURL URLWithString:pianKeMainModel.coverimg] placeholderImage:[UIImage imageNamed:@"Placehold.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    });
   
    self.Title.text = pianKeMainModel.title;
    self.Contents.text = pianKeMainModel.content;
    NSString *str = [NSString stringWithFormat:@"%@·%@",pianKeMainModel.name,pianKeMainModel.enname];
    self.name.text = str;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        positionAnimation.springBounciness = 10;
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    }else{
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
        scaleAnimation.springBounciness = 20.f;
        [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}


@end
