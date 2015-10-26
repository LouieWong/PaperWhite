//
//  AssModel.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/15.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "AssortmentModel.h"

@implementation AssortmentModel
@dynamic description;
//+(NSDictionary *)replacedKeyFromPropertyName{
//    return @{@"Description":@"description"};
//}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}
@end
@implementation StoriesModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;//JSONModel提供给我们的接口，有了它等于给所有属性加了<option>
}
@end
@implementation AssortmentArrayModel
@end

@implementation AssortmentArrayOtherModel
@dynamic description;
//+(NSDictionary *)replacedKeyFromPropertyName{
//    
//    return @{@"Description":@"description"};
//    
//}
@end
