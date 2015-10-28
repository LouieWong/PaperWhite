//
//  DataBase.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/25.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaseBase : NSObject
/**
 *  解析主页故事数据
 **/
+ (NSMutableArray *)pasePianKeListData:(id)data;

/**
 *  解析详情页数据
 **/
+ (NSMutableArray *)pasePianKeListDetailData:(id)data;
/**
 *  解析分类数据
 **/
+ (NSMutableArray *)pasePianKeClassifyData:(id)data;

@end
