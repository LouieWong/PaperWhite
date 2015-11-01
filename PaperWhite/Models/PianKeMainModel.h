//
//  PianKeMainModel.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/26.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol PianKeDetailShareModel
@end
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
 *  详情页分享数据
 **/
@interface PianKeDetailShareModel : JSONModel
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;
@end

/**
 *  详情数据
 **/
@interface PianKeDetailModel : JSONModel
@property (nonatomic,copy) NSString *contentid;
@property (nonatomic,copy) NSString *html;
@property (nonatomic) PianKeDetailShareModel *shareinfo;


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


/**
 *  分类list数据
 **/
@interface PianKeClassifyListModel : JSONModel

@property (nonatomic) NSNumber *type;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *coverimg;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *enname;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic) NSArray *imglist;
/**
 *  详情页面分享数据
 **/
@end


