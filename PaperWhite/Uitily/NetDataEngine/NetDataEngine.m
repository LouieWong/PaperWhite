//
//  NetDataEngine.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/25.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "NetDataEngine.h"
#import <AFHTTPRequestOperationManager.h>
@interface NetDataEngine ()
@property (nonatomic) AFHTTPRequestOperationManager *manager;
@property (nonatomic,copy) FailedBlockType failedBlock;
@end
@implementation NetDataEngine

+ (instancetype)sharedInstance
{
    static NetDataEngine *s_manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!s_manager) {
            s_manager = [[NetDataEngine alloc]init];
        }
    });
    return s_manager;
}

- (instancetype)init{
    if (self = [super init]) {
        _manager = [[AFHTTPRequestOperationManager alloc]init];
        NSSet *set =_manager.responseSerializer.acceptableContentTypes;
        NSMutableSet *mset = [NSMutableSet setWithSet:set];
        [mset addObject:@"application/x-javascript"];
        [mset addObject:@"text/html"];
    }
    return self;
}
- (void)post:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager POST:strUrl parameters:paramenters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}
- (void)get:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}


- (void)startNetDataEngine {
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            default:
                self.failedBlock([NSError errorWithDomain:@"网络不通" code:-1000 userInfo:@{NSLocalizedDescriptionKey:@"网络不通"}]);
                break;
        }
    }];
}
#pragma mark - 页面获取数据
- (void)requsetPianKeIndexFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self post:url parameters:paramenters success:successBlock failed:failedBlock];
}
- (void)requsetPianKeIndexDetailFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock
{
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self post:url parameters:paramenters success:successBlock failed:failedBlock];

}
- (void)requsetPianKeClassifyFrom:(NSString *)url parameters:paramenters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock
{
    self.failedBlock = failedBlock;
    [self startNetDataEngine];
    [self get:url parameters:paramenters success:successBlock failed:failedBlock];
}

@end
