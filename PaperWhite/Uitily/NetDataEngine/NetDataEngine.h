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

- (void)requsetIndexFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
- (void)requsetIndexDetailFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
- (void)requsetPianKeIndexFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;
@end
