//
//  NewsCell.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PianKeMainModel.h"
#import "UIImageView+WebCache.h"
#define kdayPaperCellID @"dayPaPerCellID"
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *contents;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TitleConstraint;

- (void)updateModel:(PianKeMainModel*)model;

@end
