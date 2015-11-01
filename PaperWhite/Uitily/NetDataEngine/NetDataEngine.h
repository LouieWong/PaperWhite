//
//  NetDataEngine.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/25.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlockType) (id responsData);
typedef void(^FailedBlockType)  (NSError *error);

@interface NetDataEngine : NSObject

+ (instancetype)sharedInstance;
/**
 *  片刻首页
 **/
- (void)requsetPianKeIndexFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
/**
 *  片刻首页详情
 **/
- (void)requsetPianKeIndexDetailFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
/**
 *  片刻分类
 **/
- (void)requsetPianKeClassifyFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
/**
 *  片刻分类详情类型
 **/
- (void)requsetPianKeClassifyTypeFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;

@end
