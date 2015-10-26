//
//  AssModel.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/15.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "JSONModel.h"
@protocol StoriesModel;
@protocol AssortmentArrayOtherModel;
@interface AssortmentModel : JSONModel

@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *background;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic)NSArray<StoriesModel> *stories;

@end
@interface StoriesModel : JSONModel
@property (nonatomic,copy)NSString *title;
@property (nonatomic)NSNumber *id;
@property (nonatomic)NSArray *images;
@end

@interface AssortmentArrayModel : JSONModel
@property (nonatomic) NSArray <AssortmentArrayOtherModel> *others;
@end
@interface AssortmentArrayOtherModel : JSONModel
@property (nonatomic,copy) NSString *thumbnail;
@property (nonatomic,copy) NSString *description;
@property (nonatomic)NSNumber *id;
@property (nonatomic,copy) NSString *name;
@end

