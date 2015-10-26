//
//  DataBase.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/25.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "PaseBase.h"
#import "DayNewsModel.h"
#import "PianKeMainModel.h"
@implementation PaseBase
/**
 *  解析主页故事数据
 **/
//+ (NSDictionary *)paseIndexStroriesData:(id)data
//{
////
//    return nil;
//}
+ (NSArray *)paseIndexStroriesData:(id)data
{
    NSArray *dataKey = [data objectForKey:@"stories"];
    NSMutableArray *marr = [NSMutableArray array];
    for (NSDictionary *obj in dataKey) {
        Stories_DayNewsModel *model = [[Stories_DayNewsModel alloc]initWithDictionary:obj error:nil];
        [marr addObject:model];
    }
    return marr;
}
+ (NSDictionary *)paseIndexStroriesDetailData:(id)data
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
    Detail_DayNewsModel *model = [[Detail_DayNewsModel alloc]initWithDictionary:data error:nil];
    NSLog(@"%@",model);
    [mdic addEntriesFromDictionary:data];
    return mdic;
}
+ (NSArray *)pasePianKeListData:(id)data
{
    NSDictionary *dict = [data objectForKey:@"data"];
    NSArray *list = [dict objectForKey:@"list"];
    NSMutableArray *marr = [NSMutableArray array];
    for (NSDictionary *obj in list) {
        PianKeMainModel *model = [[PianKeMainModel alloc]initWithDictionary:obj error:nil];
        [marr addObject:model];
    }
    return marr;
}
//+ (NSDictionary *)pasePianKeListDetailData:(id)data
//{
//    
//}

@end
