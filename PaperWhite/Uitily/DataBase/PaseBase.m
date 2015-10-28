//
//  DataBase.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/25.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "PaseBase.h"

#import "PianKeMainModel.h"
@implementation PaseBase
+ (NSMutableArray *)pasePianKeListData:(id)data
{
    NSDictionary *dict = [data objectForKey:@"data"];
    NSArray *list = [dict objectForKey:@"list"];
    NSMutableArray *marr = [NSMutableArray array];
    for (NSDictionary *obj in list) {
        PianKeMainModel *model = [[PianKeMainModel alloc]initWithDictionary:obj error:nil];
        if (![model.name isEqualToString:@"音乐"]) {
            if (![model.name isEqualToString:@"Ting"]) {
                [marr addObject:model];
            }

        }
        
    }
    return marr;
}
+ (NSMutableArray *)pasePianKeListDetailData:(id)data
{
    NSDictionary *dict = [data objectForKey:@"data"];
    NSMutableArray *marr = [NSMutableArray array];
    PianKeIndexDetailModel  *model =[[PianKeIndexDetailModel alloc]initWithDictionary:dict error:nil];
    [marr addObject:model];
    return marr;
    
}
+ (NSMutableArray *)pasePianKeClassifyData:(id)data
{
    NSDictionary *dict = [data objectForKey:@"data"];
    NSArray *array = [dict objectForKey:@"list"];
    NSMutableArray *marr = [NSMutableArray array];
    for (id obj in array) {
        PiankeClassifyModel *model = [[PiankeClassifyModel alloc]initWithDictionary:obj error:nil];
        [marr addObject:model];
    }
    return marr;
}

@end
