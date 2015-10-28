//
//  ClassifyViewController.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/28.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "ClassifyViewController.h"
#import "CacheManager.h"
@interface ClassifyViewController ()

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self fetchData];
    
}
#pragma mark - 搭建界面
- (void)initUI
{
    self.view.backgroundColor = [UIColor randomcolor];
}
#pragma mark - 数据处理
- (void)fetchData {
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}
- (void)fetchDataFromServer
{
    
}
- (void)fetchOldWebData {
    //    if (![self fetchOldWebDataFromLocal]) {
    [self fetchOldWebDataFromServer];
    //    }
}
- (void)fetchOldWebDataFromServer
{
    
}

- (BOOL)fetchOldWebDataFromLocal
{
//    self.OldWebDataUrl = [NSString stringWithFormat:@"%@&client=2&limit=10&start%d",kIndexUrl,_dataNumber];
//    if ([CacheManager isCacheDataInvalid:self.OldWebDataUrl]) {
//        id respondData = [CacheManager readDataAtUrl:self.OldWebDataUrl];
//        [self parseOldCacheData:respondData];
//        [self.aTableView reloadData];
//        _dataNumber += 10;
//        return YES;
//}
    
    return NO;
    
}
//读取本地数据
- (BOOL)fetchDataFromLocal
{
    
//    if ([CacheManager isCacheDataInvalid:kIndexUrl]) {
//        id respondData = [CacheManager readDataAtUrl:kIndexUrl];
//        [self parseCacheData:respondData];
//        [self.aTableView reloadData];
//        return YES;
//    }
    
    return NO;
}
- (void)parseCacheData:(id)respondData
{
//    //解析数据，刷新表
//    self.dataKey = [NSMutableArray arrayWithArray:[PaseBase pasePianKeListData:respondData]];
}
- (void)parseOldCacheData:(id)respondData
{
//    //解析数据，刷新表
//    NSArray *array = [PaseBase pasePianKeListData:respondData];
//    [self.dataKey addObjectsFromArray:array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
