//
//  PianKeMainModel.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/26.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "PianKeMainModel.h"

@implementation PianKeMainModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}
@end
@implementation PianKeIndexDetailModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}
@end

@implementation PiankeClassifyModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}
@end