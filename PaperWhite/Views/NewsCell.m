//
//  NewsCell.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/24.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "NewsCell.h"
#import "NetDataEngine.h"

@implementation NewsCell

- (void)awakeFromNib {
    self.backView.layer.cornerRadius = 6.0;
    self.backView.contentMode = UIViewContentModeScaleAspectFill;
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.backView.clipsToBounds  = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
}
- (void)updateModel:(PianKeMainModel*)pianKeMainModel
{
//    NSString *url =[NSString stringWithFormat:kdefineUrl,(stories_DayNewsModel.id)];
//    [[NetDataEngine sharedInstance]requsetIndexFrom:url success:^(id responsData) {
//        NSLog(@"%@",responsData);
//        Detail_DayNewsModel *model = [[Detail_DayNewsModel alloc]initWithDictionary:responsData error:nil];
//       //


//    } failed:^(NSError *error) {
//        
//    }];
    [self.indexImageView sd_setImageWithURL:[NSURL URLWithString:pianKeMainModel.coverimg] placeholderImage:[UIImage imageNamed:@"Placehold.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
                }];

    self.Title.text = pianKeMainModel.title;
    self.Contents.text = pianKeMainModel.content;
    NSString *str = [NSString stringWithFormat:@"%@·%@",pianKeMainModel.name,pianKeMainModel.enname];
    self.name.text = str;
       }
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        positionAnimation.springBounciness = 10;
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    }else{
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(1.618, 1.618)];
        scaleAnimation.springBounciness = 20.f;
        [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];


    }
}
//- (void)setSelected:(BOOL)selected
//{
//        POPSpringAnimation *positionShakeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//        positionShakeAnimation.velocity = @200;
//        positionShakeAnimation.springBounciness = 20;
//        [self.layer pop_addAnimation:positionShakeAnimation forKey:@"positionShakeAnimation"];
//}

@end
