//
//  RootViewController.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/24.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "RootViewController.h"
#import "PianKeListCell.h"
#import <Masonry.h>
#import <POP.h>
#import "PaperButton.h"
#import "NetDataEngine.h"
#import "PaseBase.h"
#import "UIImage+Blur.h"
#import <MBProgressHUD.h>
#import "JHRefresh.h"
#import "DetailViewController.h"
#import "CacheManager.h"
#import "ScrollButton.h"
#import "ClassifyViewController.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic)UIColor *tmpColor;
@property (nonatomic)UICollectionView *aCollectionView;
@property (nonatomic)UIButton *rightBarButton;
@property (nonatomic)AFHTTPRequestOperationManager *manager;
@property (nonatomic)int dataNumber;
@property (nonatomic)NSMutableArray *dataKey;
@property (nonatomic)NSMutableArray *classifyArray;
@property (nonatomic)NSString *OldWebDataUrl;
@property (nonatomic)NSDictionary *dataSource;
@property (nonatomic)UITableView *aTableView;
@property (nonatomic)PianKeIndexDetailModel  *pianKeIndexDetailModel;
@property (nonatomic)PianKeMainModel *pianKeIndexModel;
@property (nonatomic)UITableViewCell *oldCell;
@property (nonatomic)UIButton *oldButton;
@property (nonatomic)BOOL *isSelected;
@property (nonatomic)UIScrollView *aScrollView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchData];
    [self fetchClassifyFromServer];
    [self initUI];
    
    
}
#pragma mark - 数据处理
- (void)fetchData {
       if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}
- (void)fetchOldWebData {
//    if (![self fetchOldWebDataFromLocal]) {
        [self fetchOldWebDataFromServer];
//    }
}

- (BOOL)fetchOldWebDataFromLocal
{
    self.OldWebDataUrl = [NSString stringWithFormat:@"%@&client=2&limit=10&start%d",kIndexUrl,_dataNumber];
    if ([CacheManager isCacheDataInvalid:self.OldWebDataUrl]) {
        id respondData = [CacheManager readDataAtUrl:self.OldWebDataUrl];
        [self parseOldCacheData:respondData];
        [self.aTableView reloadData];
        _dataNumber += 10;
        return YES;
    }
    
    return NO;

}
//读取本地数据
- (BOOL)fetchDataFromLocal
{
    
    if ([CacheManager isCacheDataInvalid:kIndexUrl]) {
        id respondData = [CacheManager readDataAtUrl:kIndexUrl];
        [self parseCacheData:respondData];
        [self.aTableView reloadData];
        return YES;
    }
    
    return NO;
}
- (void)parseCacheData:(id)respondData
{
    //解析数据，刷新表
    self.dataKey = [NSMutableArray arrayWithArray:[PaseBase pasePianKeListData:respondData]];
}
- (void)parseOldCacheData:(id)respondData
{
    //解析数据，刷新表
    NSArray *array = [PaseBase pasePianKeListData:respondData];
    [self.dataKey addObjectsFromArray:array];
}
#pragma mark - 获取数据
- (void)fetchDataFromServer
{
    NSString *url = kIndexUrl;
    NSDictionary *dic = @{@"client":@(2),@"limit":@(10),@"start":@(0)};
    [[NetDataEngine sharedInstance]requsetPianKeIndexFrom:url parameters:dic success:^(id responsData) {
       self.dataKey  = [PaseBase pasePianKeListData:responsData];
//        [self.dataKey removeAllObjects];
//        [self.dataKey addObjectsFromArray:array];
        [self.aTableView reloadData];
        self.dataNumber = 10;
        NSLog(@"%@",@"从网络获取数据");
        [CacheManager clearDisk];
        [CacheManager saveData:responsData atUrl:kIndexUrl];
    } failed:^(NSError *error) {
        NSLog(@"网络真差");
    }];
}
- (void)fetchClassifyFromServer
{
    NSString *classifyUrl = @"http://api2.pianke.me/read/columns?client=2";
    [[NetDataEngine sharedInstance]requsetPianKeClassifyFrom:classifyUrl parameters:nil success:^(id responsData){
        
        NSArray *array = [PaseBase pasePianKeClassifyData:responsData];
        self.classifyArray = [NSMutableArray array];
        [self.classifyArray addObjectsFromArray:array];
        for (int i =0; i<array.count; i++) {
            PiankeClassifyModel *model = [array objectAtIndex:i];
            NSLog(@"%@",model);
            UIButton *button = (UIButton*)[self.aScrollView viewWithTag:100+i];
            UIImageView *aimageView = (UIImageView*)[button viewWithTag:button.tag+100];
            [aimageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                UIImage *aimage =[UIImage setBlurImage:aimageView.image quality:0.5 blurred:0.5];
                aimageView.image = aimage;
            }];
            [button setTitle:model.name forState:UIControlStateNormal];
            button.tag =  [model.type intValue];
        }
        NSLog(@"%@",self.classifyArray);
    } failed:^(NSError *error) {
        
    }];

}
- (void)fetchOldWebDataFromServer
{
    NSString *url = kIndexUrl;
    if (_dataNumber == 0) {
        _dataNumber = 10;
    }
    NSDictionary *dic = @{@"client":@(2),@"limit":@(10),@"start":@(_dataNumber)};
    [[NetDataEngine sharedInstance]requsetPianKeIndexFrom:url parameters:dic success:^(id responsData) {
        NSArray *array = [PaseBase pasePianKeListData:responsData];
        [self.dataKey addObjectsFromArray:array];
        [self.aTableView reloadData];
        _dataNumber += 10;
        self.OldWebDataUrl = [NSString stringWithFormat:@"%@&client=2&limit=10&start%d",kIndexUrl,_dataNumber];
        [CacheManager saveData:responsData atUrl:self.OldWebDataUrl];
    } failed:^(NSError *error) {
        NSLog(@"网络真差");
    }];
}
#pragma mark - 搭建界面
- (void)initUI
{
    self.view.backgroundColor = [UIColor cyanGreenColor];
    [self customNav];
    [self createTableView];
    [self createScrollView];
}

- (void)createNav
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)customNav
{
    self.navigationController.navigationBar.barTintColor = self.view.backgroundColor;
    
    PaperButton *button = [PaperButton button];
    [button addTarget:self action:@selector(animateTableView:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor whiteColor];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButton;
}
- (void)animateTableView:(id)sender
{
    
}
- (void)createTableView
{
    self.aTableView = [[UITableView alloc]init];
    [_aTableView setTransform:CGAffineTransformMakeRotation(-M_PI/2)];
    [self.aTableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height-64)*0.80)];
     [self.aTableView registerNib:[UINib nibWithNibName:@"PianKeListCell" bundle:nil] forCellReuseIdentifier:indexCellID];
    [self.view addSubview:_aTableView];
    _aTableView.delegate =self;
    _aTableView.dataSource = self;
    _aTableView.rowHeight = self.view.frame.size.width;
    _aTableView.estimatedRowHeight = 200 ;
    _aTableView.backgroundColor = [UIColor clearColor];
    _aTableView.separatorColor = [UIColor clearColor];
    _aTableView.showsHorizontalScrollIndicator = NO;
    _aTableView.showsVerticalScrollIndicator = NO;
    [self fetchNewData];
    [self fetchOldData];
    
}
- (void)createScrollView
{
    self.aScrollView = [[UIScrollView alloc]init];
    [_aScrollView setFrame:CGRectMake(0, (self.view.frame.size.height-64)*0.80, self.view.frame.size.width, (self.view.frame.size.height-64)*0.20)];
    _aScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_aScrollView];
    for (int i =0 ; i<9; i++) {
        ScrollButton *button = [[ScrollButton alloc]initWithFrame:CGRectMake(5+i*105, self.aScrollView.frame.size.height*0.80, 100, 100)];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 5.0;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = NO;
        button.tag = 100+i;
        [button setTitleColor:[UIColor deepBlackColor]forState:UIControlStateNormal];
//        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        UIImageView *aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, button.frame.size.width-8, button.frame.size.width-8)];
        aImageView.tag = button.tag+100;
        aImageView.alpha =0.7;
        aImageView.layer.cornerRadius = 10.0;
        [button addSubview:aImageView];
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
        [button addGestureRecognizer:swipeUp];
        [self.aScrollView addSubview:button];
    }
    _aScrollView.contentSize = CGSizeMake(9*105+5,(self.view.frame.size.height-64)*0.20);
    _aScrollView.showsHorizontalScrollIndicator = NO;
}
- (void)swipeUp:(UISwipeGestureRecognizer*)sender
{
    UIButton *button = (UIButton*)sender.view;
    if (button.selected == YES) {
//         NSLog(@"分类");
        ClassifyViewController *controller = [[ClassifyViewController alloc]init];
        NSLog(@"%ld",button.tag);
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)buttonClick:(UIButton*)sender
{

    if (!sender.selected) {
        NSLog(@"弹出");
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        CGPoint point = sender.layer.position;
        NSLog(@"%f",point.y);
        
        springAnimation.toValue =  @(sender.layer.position.y-40);
        springAnimation.springBounciness = 20.0; //弹性速度
        springAnimation.springSpeed = 20.0;
    
        [sender.layer pop_addAnimation:springAnimation forKey:@"springAnimation10"];
        sender.selected = YES;

    }else{
        NSLog(@"缩回");
        POPSpringAnimation *springAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        springAnimation1.toValue =  @(sender.layer.position.y+40);
        springAnimation1.springBounciness = 20.0; //弹性速度
        springAnimation1.springSpeed = 20.0;
        
        [sender.layer pop_addAnimation:springAnimation1 forKey:@"springAnimation11"];
        sender.selected = NO;
    }

}
#pragma mark - 刷新加载
- (void)fetchNewData
{
    __weak RootViewController *weakSelf = self;
    //下拉刷新
    [self.aTableView addRefreshHeaderViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchDataFromServer];
        
        //结束动画
        [weakSelf.aTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        NSLog(@"缓存%ld",[CacheManager cacheSize]);

    }];

}
- (void)fetchOldData
{
    __weak RootViewController *weakSelf = self;
    //上拉加载
    [self.aTableView addRefreshFooterViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchOldWebData];

        NSLog(@"缓存%ld",[CacheManager cacheSize]);
        [weakSelf.aTableView footerEndRefreshing];
    }];

}

#pragma mark - uitableView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *cells = [self.aTableView visibleCells];//当前可视界面中全部的cell数组
    if (cells.firstObject == self.oldCell) {
        return;
    }
    //判断是不是上一个Cell
    self.oldCell = cells[0];//当前界面中第一个
    self.tmpColor = [UIColor randomcolor];
    self.view.backgroundColor = _tmpColor;
    self.navigationController.navigationBar.barTintColor = _tmpColor;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataKey.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PianKeListCell *cell = [self.aTableView dequeueReusableCellWithIdentifier:indexCellID];
    NSArray *array = self.dataKey;
    cell.backgroundColor = [UIColor clearColor];
    PianKeMainModel *model =[array objectAtIndex:indexPath.row];
    [cell updateModel:model];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    PianKeMainModel *model = self.dataKey[indexPath.row];
    detail.pianKeIndexModel = model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSMutableArray*)datakey
{
    if (self.dataKey == nil ) {
        self.dataKey = [NSMutableArray array];
        
    }
    return _dataKey;
}
//- (NSMutableArray*)classifyArray
//{
//    if (self.classifyArray == nil ) {
//        _classifyArray = [NSMutableArray array];
//        
//    }
//    return _classifyArray;
//}
@end
