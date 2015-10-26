//
//  NewsCell.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/24.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>
#import <UIImageView+WebCache.h>
#import "DayNewsModel.h"
#import "PianKeMainModel.h"
#define indexCellID @"indexCellID"
@interface NewsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *indexImageView;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Contents;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic) Stories_DayNewsModel *stories_DayNewsModel;
- (void)updateModel:(PianKeMainModel*)pianKeMainModel;
@end
