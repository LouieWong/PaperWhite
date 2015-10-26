//
//  RootViewController.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/24.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "RootViewController.h"
#import "NewsCell.h"
#import <Masonry.h>
#import <POP.h>
#import "PaperButton.h"
#import "NetDataEngine.h"
#import "PaseBase.h"
#import <MBProgressHUD.h>
@interface RootViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
@property (nonatomic)UIColor *tmpColor;
@property (nonatomic)UICollectionView *aCollectionView;
@property (nonatomic)UIButton *rightBarButton;
@property (nonatomic)AFHTTPRequestOperationManager *manager;
@property (nonatomic)Stories_DayNewsModel *stories_DayNewsModel;
@property (nonatomic)DayNewsModel *dayNewsModel;
@property (nonatomic)Detail_DayNewsModel *detail_DayNewsModel;

@property (nonatomic) NSArray *dataKey;

@property (nonatomic) NSDictionary *dataSource;




@property (nonatomic) UICollectionViewCell *oldCell;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self fetchData];
    
}
- (void)fetchData {
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}
- (BOOL)fetchDataFromLocal {
    return NO;
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor randomcolor];
//    [self createNav];
    [self customNav];
    [self creatLayout];
}
#pragma mark - 搭建界面
- (void)createNav
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)customNav
{
    self.navigationController.navigationBar.barTintColor = self.view.backgroundColor;
    
    PaperButton *button = [PaperButton button];
    [button addTarget:self action:@selector(animateTitleLabel:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor whiteColor];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButton;

    
}
- (void)animateTitleLabel:(id)sender
{
    
}
- (void)creatLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height*0.80);
    
    self.aCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.8) collectionViewLayout:layout];
    _aCollectionView.backgroundColor = [UIColor clearColor];
    [_aCollectionView registerNib:[UINib  nibWithNibName:@"NewsCell" bundle:nil] forCellWithReuseIdentifier:indexCellID];
    _aCollectionView.dataSource = self;
    _aCollectionView.delegate = self ;
    _aCollectionView.showsHorizontalScrollIndicator = NO;
    
    _aCollectionView.pagingEnabled = YES;
    [self.view addSubview:_aCollectionView];
}
#pragma mark - 获取数据
- (void)fetchDataFromServer
{
    NSString *url = kIndexUrl;
   
    NSDictionary *dic = @{@"client":@(2),@"limit":@(10),@"start":@(0)};
    [[NetDataEngine sharedInstance]requsetPianKeIndexFrom:url parameters:dic success:^(id responsData) {
        NSLog(@"responsData");
        self.dataKey = [PaseBase pasePianKeListData:responsData];
        NSLog(@"%@",self.dataKey);
        [self.aCollectionView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"千峰网真卡");
    }];
}

#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataKey.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [self.aCollectionView dequeueReusableCellWithReuseIdentifier:indexCellID forIndexPath:indexPath];
//    self.tmpColor = [UIColor randomcolor];
//    self.view.backgroundColor = _tmpColor;
//    self.navigationController.navigationBar.barTintColor = _tmpColor;
    NSArray *array = self.dataKey;
    PianKeMainModel *model =[array objectAtIndex:indexPath.row];
    [cell updateModel:model];
        return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *cells = [self.aCollectionView visibleCells];//当前可视界面中全部的cell数组
    if (cells.firstObject == self.oldCell) {
        return;
    }
    //判断是不是上一个Cell
    
    self.oldCell = cells[0];//当前界面中第一个
    self.tmpColor = [UIColor randomcolor];
    self.view.backgroundColor = _tmpColor;
    self.navigationController.navigationBar.barTintColor = _tmpColor;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 0, 10, 0);
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
- (NSArray*)datakey
{
    if (self.dataKey == nil ) {
        self.dataKey = [NSArray array];
        
    }
    return _dataKey;
}

@end
