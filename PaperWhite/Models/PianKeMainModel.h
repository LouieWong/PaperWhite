//
//  PianKeMainModel.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/26.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PianKeMainModel : JSONModel
/**
 *  首页数据
 **/
@property (nonatomic) NSNumber *type;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *coverimg;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *enname;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic) NSArray *imglist;


@end
/**
 *  首页详情数据
 **/
@interface PianKeIndexDetailModel : JSONModel
@property (nonatomic,copy) NSString *contentid;
@property (nonatomic,copy) NSString *html;


@end
/**
 *  分类数据
 **/
@interface PiankeClassifyModel : JSONModel
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *enname;
@property (nonatomic,copy) NSString *coverimg;
@property (nonatomic) NSNumber *type;
@end

