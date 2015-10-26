//
//  AnimationVideoModel.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/11.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "JSONModel.h"

@protocol Anime_AnimationVideoModel;
@protocol Recommend_AnimationVideoModel;
@protocol VideoSource_AnimationVideoModel;
@protocol Category_AnimationVideoModel;
#pragma mark - 视频清晰度
@interface VideoSource_AnimationVideoModel : JSONModel

@property (nonatomic,copy) NSString *uhd;
@property (nonatomic,copy) NSString *hd;
@property (nonatomic,copy) NSString *sd;

@end

//@protocol List_AnimationVideoModel;
//@protocol Data_AnimationVideoModel;

#pragma mark - Cell数据
@interface Anime_AnimationVideoModel : JSONModel
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *Author;
@property (nonatomic,copy) NSString *Year;
@property (nonatomic,copy) NSString *Duration;
@property (nonatomic,copy) NSString *VideoUrl;   //视频链接地址
@property (nonatomic,copy) NSString *VideoSite;
@property (nonatomic,copy) NSString *Brief;      //描述文字
@property (nonatomic,copy) NSString *HomePic;
@property (nonatomic,copy) NSString *DetailPic;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic) VideoSource_AnimationVideoModel *VideoSource;
@end
#pragma mark - 滚动视图
@interface Recommend_AnimationVideoModel : JSONModel

@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *Author;
@property (nonatomic,copy) NSString *Year;
@property (nonatomic,copy) NSString *Duration;
@property (nonatomic,copy) NSString *VideoUrl;   //视频链接地址
@property (nonatomic,copy) NSString *VideoSite;
@property (nonatomic,copy) NSString *Brief;      //描述文字
@property (nonatomic,copy) NSString *HomePic;
@property (nonatomic,copy) NSString *DetailPic;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic)  VideoSource_AnimationVideoModel *VideoSource;
@end
#pragma mark - 分类
@interface Category_AnimationVideoModel : JSONModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *count;
@end


@interface List_AnimationVideoModel : JSONModel
@property (nonatomic) NSArray <Anime_AnimationVideoModel>*anime;
@property (nonatomic) NSArray <Recommend_AnimationVideoModel>*recommend;
@property (nonatomic) NSArray <Category_AnimationVideoModel>*category;
@end
@interface Data_AnimationVideoModel :JSONModel

@property (nonatomic,copy) NSString *result;
@property (nonatomic)  List_AnimationVideoModel *list;

@end
@interface AnimationVideoModel : JSONModel

@property (nonatomic)  Data_AnimationVideoModel *data;

@end









