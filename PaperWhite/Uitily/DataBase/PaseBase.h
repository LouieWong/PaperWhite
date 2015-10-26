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
+ (NSArray *)paseIndexStroriesData:(id)data;
//+ (NSDictionary *)paseIndexStroriesData:(id)data;

/**
 *  解析详情页数据
 **/
+ (NSDictionary *)paseIndexStroriesDetailData:(id)data;

+ (NSArray *)pasePianKeListData:(id)data;
+ (NSDictionary *)pasePianKeListDetailData:(id)data;

@end
