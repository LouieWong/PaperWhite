//
//  NewCell.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/27.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>
#import <UIImageView+WebCache.h>
#import "PianKeMainModel.h"
#define indexCellID @"indexCellID"
@interface PianKeListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *indexImageView;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Contents;
@property (weak, nonatomic) IBOutlet UILabel *name;

- (void)updateModel:(PianKeMainModel*)pianKeMainModel;
@end
