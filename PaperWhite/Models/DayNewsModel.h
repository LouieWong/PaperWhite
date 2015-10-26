//
//  AppIndexBigJSON.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "JSONModel.h"
@protocol Stories_DayNewsModel;
@protocol TopStories_DayNewsModel;
@protocol CommentsModel;

@interface Stories_DayNewsModel : JSONModel
+ (NSArray*)parseRespondData:(NSDictionary*)respondData;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *ga_prefix;
@property (nonatomic,copy) NSString *title;

@end

@interface TopStories_DayNewsModel : JSONModel

@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *ga_prefix;
@property (nonatomic,copy) NSString *title;
@end

@interface Detail_DayNewsModel : JSONModel

@property (nonatomic,copy) NSString *body;
@property (nonatomic,copy) NSString<Optional> *image_source;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *share_url;
@property (nonatomic)      NSArray<Optional> *js;
@property (nonatomic,copy) NSString *ga_prefix;
@property (nonatomic)      NSNumber *id;
@property (nonatomic)      NSArray *css;

@end

@interface DetailExtra_DayNewsModel : JSONModel
@property (nonatomic)NSNumber *long_comments;
@property (nonatomic)NSNumber *short_comments;
@property (nonatomic)NSNumber *comments;
@property (nonatomic)NSNumber *popularity;

@end

@interface DayNewsModel : JSONModel

@property (nonatomic,copy) NSString *date;
@property (nonatomic) NSArray<Stories_DayNewsModel> *stories;
@property (nonatomic) NSArray<TopStories_DayNewsModel> *top_stories;
@end

@interface Short_CommentModel : JSONModel

@property (nonatomic) NSArray<CommentsModel> *comments;

@end

@interface Long_CommentModel : JSONModel

@property (nonatomic) NSArray<CommentsModel> *comments;

@end

@interface CommentsModel : JSONModel
@property (nonatomic,copy) NSString* author;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* avatar;
@property (nonatomic) NSNumber *timer;
@property (nonatomic) NSNumber *id;
@property (nonatomic) NSNumber *likes;
@end

