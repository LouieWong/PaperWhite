//
//  ClassifyViewController.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/28.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "ClassifyViewController.h"
#import "CacheManager.h"
#import "NetDataEngine.h"
#import "PaseBase.h"
#import "NewsCell.h"
#import <Masonry.h>
#import "DetailViewController.h"
#import "CacheManager.h"
#import "JHRefresh.h"
#import "PaperButton.h"
@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UIColor *tmpColor;
@property (nonatomic) UITableView *aTableView;
@property (nonatomic) int dataNumber;
@property (nonatomic,copy) NSString *OldWebDataUrl;
@property (nonatomic,copy) NSString *NewWebDataUrl;
@property (nonatomic) NSMutableArray *dataNewDataArray;
@property (nonatomic) UIImageView *backImageView;

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
   
    [self fetchData];
    [self initUI];

    
    
}
- (void)config
{
//    self.tmpColor = self.navigationController.navigationBar.barTintColor;
//    self.view.backgroundColor = _tmpColor;
    self.NewWebDataUrl = [NSString stringWithFormat:@"%@&sort=addtime&client=2&limit=10&start=%d$typeid=%ld",kIndexUrl,0,self.type];

        self.view.backgroundColor = [UIColor cyanGreenColor];
        self.backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backImageView.clipsToBounds  = YES;
        [self.view addSubview:self.backImageView];
    self.backImageView.image = self.backImage;
}

#pragma mark - 搭建界面
- (void)initUI
{

    [self createTableView];
    [self customNav];
}
- (void)createTableView
{
    _aTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _aTableView.backgroundColor = _tmpColor;
    [_aTableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:kdayPaperCellID];
    _aTableView.delegate  = self;
    _aTableView.dataSource = self;
    _aTableView.separatorColor = [UIColor clearColor];
    _aTableView.rowHeight =UITableViewAutomaticDimension;
    _aTableView.estimatedRowHeight = 100;
    [self.view addSubview:_aTableView];
    [_aTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [self fetchNewData];
    [self fetchOldData];
}
- (void)customNav
{
    //    self.navigationController.navigationBar.barTintColor = self.view.backgroundColor;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
    PaperButton *button = [PaperButton button];
    [button addTarget:self action:@selector(animateTableView:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor whiteColor];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = self.title;
    self.navigationItem.rightBarButtonItem = barButton;
}
- (void)animateTableView:(id)sender
{
    
}
#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataNewDataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [_aTableView dequeueReusableCellWithIdentifier:kdayPaperCellID];
    PianKeMainModel *model = self.dataNewDataArray[indexPath.row];
    [cell updateModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *controller = [[DetailViewController alloc]init];
    PianKeMainModel *model = self.dataNewDataArray[indexPath.row];
    controller.pianKeIndexModel = model;
    controller.backImage = self.backImage;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - 刷新加载
- (void)fetchNewData
{
    __weak ClassifyViewController *weakSelf = self;
    //下拉刷新
    [self.aTableView addRefreshHeaderViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchDataFromServer];
        
        //结束动画
        [weakSelf.aTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }];
    
}
- (void)fetchOldData
{
    __weak ClassifyViewController *weakSelf = self;
    //上拉加载
    [self.aTableView addRefreshFooterViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchOldWebData];
        
        [weakSelf.aTableView footerEndRefreshing];
    }];
    
}

#pragma mark - 数据处理
- (void)fetchData {
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
    
}
- (BOOL)fetchDataFromLocal
{
    NSLog(@"%@",self.NewWebDataUrl);
    if ([CacheManager isCacheDataInvalid:self.NewWebDataUrl]) {
        id respondData = [CacheManager readDataAtUrl:self.NewWebDataUrl];
        [self parseCacheData:respondData];
        [self.aTableView reloadData];
        NSLog(@"这是本地数据");
        return YES;
    }

    return NO;
}
- (void)fetchDataFromServer
{
    NSString *url = kClassifyUrl;
    NSDictionary *dic = @{@"sort":@"addtime",@"start":@(0),@"client":@(2),@"typeid":@(self.type),@"limit":@(10)};
    [[NetDataEngine sharedInstance]requsetPianKeClassifyTypeFrom:url parameters:dic success:^(id responsData) {
        self.dataNewDataArray = [PaseBase pasePianKeClassifyListData:responsData];
        [CacheManager saveData:responsData atUrl:self.NewWebDataUrl];
        NSLog(@"这是网络数据");
        [self.aTableView reloadData];
    } failed:^(NSError *error) {
        
    }];

}
- (void)fetchOldWebData {
    //    if (![self fetchOldWebDataFromLocal]) {
    [self fetchOldWebDataFromServer];
    //    }
}
- (void)fetchOldWebDataFromServer
{
    if (_dataNumber == 0) {
        _dataNumber = 10;
    }
    NSString *url = [NSString stringWithFormat:@"http://api2.pianke.me/read/columns_detail"];
    NSDictionary *dic = @{@"sort":@"addtime",@"start":@(_dataNumber),@"client":@(2),@"typeid":@(self.type),@"limit":@(10)};
   
    [[NetDataEngine sharedInstance]requsetPianKeClassifyTypeFrom:url parameters:dic success:^(id responsData) {
        NSArray *array = [PaseBase pasePianKeClassifyListData:responsData];
        [self.dataNewDataArray addObjectsFromArray:array];
        _dataNumber += 10;
        [self.aTableView reloadData];
        self.OldWebDataUrl = [NSString stringWithFormat:@"%@&client=2&limit=10&start=%d$typeid=%ld",url,_dataNumber,self.type];

        [CacheManager saveData:responsData atUrl:self.OldWebDataUrl];
    } failed:^(NSError *error) {
        
    }];
    

}

#pragma mark - 读取本地数据

- (void)parseCacheData:(id)respondData
{
    //解析数据，刷新表
    self.dataNewDataArray = [NSMutableArray arrayWithArray:[PaseBase pasePianKeClassifyListData:respondData]];
    
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


- (NSMutableArray*)dataNewDataArray
{
    if (_dataNewDataArray == nil ) {
        _dataNewDataArray = [NSMutableArray array];
        
    }
    return _dataNewDataArray;
}

@end
