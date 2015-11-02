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
#import <SVProgressHUD.h>
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
@property (nonatomic)PianKeDetailModel  *pianKeIndexDetailModel;
@property (nonatomic)PianKeMainModel *pianKeIndexModel;
@property (nonatomic)UITableViewCell *oldCell;
@property (nonatomic)UIButton *oldButton;
@property (nonatomic)BOOL *isSelected;
@property (nonatomic)UIScrollView *aScrollView;
@property (nonatomic)UIImageView *backImageView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
    [self fetchData];
    [self fetchClassifyFromServer];
    [self initUI];
    
    
}
#pragma mark - 数据处理
- (void)fetchData {
//       if (![self fetchDataFromLocal]) {

    [self fetchDataFromLocal];
        [self fetchDataFromServer];
//    }
}
- (void)fetchOldWebData {
//    if (![self fetchOldWebDataFromLocal]) {
        [self fetchOldWebDataFromServer];
//    }
}

#pragma mark - 读取解析本地数据
/**
 *  第一页本地数据
 **/
- (BOOL)fetchDataFromLocal
{
    if ([CacheManager isCacheDataInvalid:kIndexUrl]) {
        id lastrespondData = [CacheManager readDataAtUrl:kIndexUrl];
        
        [self parseCacheData:lastrespondData];
        [self.aTableView reloadData];
        return YES;
    }
    
    return NO;
}
- (BOOL)fetchClassifyDataFromLocal
{
    if ([CacheManager isCacheDataInvalid:kClassifyListUrl]) {
        id lastrespondData = [CacheManager readDataAtUrl:kClassifyListUrl];
        
        [self parseClassifyCacheData:lastrespondData];
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
- (void)parseClassifyCacheData:(id)respondData
{
    //解析数据，刷新表
    self.classifyArray = [NSMutableArray arrayWithArray:[PaseBase pasePianKeClassifyData:respondData]];
    NSLog(@"%@",self.classifyArray);
    [self refetchClassify];
}
/**
 *  其他页本地数据
 **/
- (BOOL)fetchOldWebDataFromLocal
{
    self.OldWebDataUrl = [NSString stringWithFormat:@"%@&client=2&limit=10&start%d",kIndexUrl,_dataNumber];
    if ([CacheManager isCacheDataInvalid:self.OldWebDataUrl]) {
        id respondData = [CacheManager readDataAtUrl:self.OldWebDataUrl];
        [self parseOldCacheData:respondData];
        [self.aTableView reloadData];
//        return YES;
        return NO;
    }
    return NO;
}
- (void)parseOldCacheData:(id)respondData
{
    //解析数据，刷新表
    NSArray *array = [PaseBase pasePianKeListData:respondData];
    [self.dataKey addObjectsFromArray:array];
}
#pragma mark - 获取数据(AFNetWoring)
- (void)fetchDataFromServer
{
    NSString *url = kIndexUrl;
    NSDictionary *dic = @{@"client":@(2),@"limit":@(10),@"start":@(0)};
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [[NetDataEngine sharedInstance]requsetPianKeIndexFrom:url parameters:dic success:^(id responsData) {
       self.dataKey  = [PaseBase pasePianKeListData:responsData];
        [self.aTableView reloadData];
        self.dataNumber = 10;
        NSLog(@"%@",@"从网络获取数据");
        [SVProgressHUD dismissWithDelay:0.5];
        [CacheManager saveData:responsData atUrl:kIndexUrl];
    } failed:^(NSError *error) {
        NSLog(@"网络真差");
    }];
}
- (void)fetchClassifyFromServer
{
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [[NetDataEngine sharedInstance]requsetPianKeClassifyFrom:kClassifyListUrl parameters:nil success:^(id responsData){
        NSArray *array = [PaseBase pasePianKeClassifyData:responsData];
        NSLog(@"%@",array);
        [self.classifyArray addObjectsFromArray:array];
        NSLog(@"asdfffffffffffffff%@",self.classifyArray);
        [self refetchClassify];
        [CacheManager saveData:responsData atUrl:kClassifyListUrl];
        [SVProgressHUD dismissWithDelay:0.5];
    } failed:^(NSError *error) {
        NSLog(@"获取分类数据失败");
        [self fetchClassifyDataFromLocal];
    }];
}
- (void)refetchClassify
{
    NSLog(@"asdfffffffffffffff%@",self.classifyArray);
    for (int i =0; i<self.classifyArray.count; i++) {
        PiankeClassifyModel *model = [_classifyArray objectAtIndex:i];
        UIButton *button = (UIButton*)[self.aScrollView viewWithTag:100+i];
        UIImageView *aimageView = (UIImageView*)[button viewWithTag:button.tag+100];
        [aimageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImage *aimage =[UIImage setBlurImage:aimageView.image quality:0.5 blurred:0.5];
            aimageView.image = aimage;
        }];
        [button setTitle:model.name forState:UIControlStateNormal];
        button.tag =  [model.type intValue];

}
}
- (void)fetchOldWebDataFromServer
{
    NSString *url = kIndexUrl;
    NSDictionary *dic = @{@"client":@(2),@"limit":@(10),@"start":@(_dataNumber)};
    NSLog(@"%d",_dataNumber);
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [[NetDataEngine sharedInstance]requsetPianKeIndexFrom:url parameters:dic success:^(id responsData) {
        NSArray *array = [PaseBase pasePianKeListData:responsData];
        [self.dataKey addObjectsFromArray:array];
        [self.aTableView reloadData];
        _dataNumber += 10;
        NSLog(@"网络数据的加载");
        [CacheManager saveData:responsData atUrl:self.OldWebDataUrl];
        [SVProgressHUD dismissWithDelay:0.5];
    } failed:^(NSError *error) {
        NSLog(@"网络真差");
    }];
}
#pragma mark - 搭建界面
- (void)initUI
{
//    self.view.backgroundColor = [UIColor cyanGreenColor];
    [self customNav];
    [self createTableView];
    [self createScrollView];
   }
- (void)config
{
    self.dataNumber = 10;
    self.view.backgroundColor = [UIColor cyanGreenColor];
    self.backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.backImageView.clipsToBounds  = YES;
    [self.view addSubview:self.backImageView];
    UIImage *image = [UIImage setBlurImage:[UIImage imageNamed:@"BackImage"] quality:0.5 blurred:0.9];
    self.backImageView.image = image;
    UIColor *backColor = [UIColor colorWithPatternImage:image];
    self.navigationController.navigationBar.barTintColor = backColor;
    self.classifyArray = [NSMutableArray array];
}
- (void)createNav
{
    self.navigationController.navigationBarHidden = YES;
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
    self.navigationItem.title = @"首页";
    self.navigationItem.leftBarButtonItem = barButton;
//    self.navigationController.interactivePopGestureRecognizer.delegate=self;
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
        ClassifyViewController *controller = [[ClassifyViewController alloc]init];
        controller.backImage = self.backImageView.image;
        controller.type = button.tag;
        controller.title = button.titleLabel.text;
        NSLog(@"%@",controller.title);
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)buttonClick:(UIButton*)sender
{

    if (!sender.selected) {
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        springAnimation.toValue =  @(sender.layer.position.y-40);
        springAnimation.springBounciness = 20.0; //弹性速度
        springAnimation.springSpeed = 20.0;
    
        [sender.layer pop_addAnimation:springAnimation forKey:@"springAnimation10"];
        sender.selected = YES;

    }else{
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
        
        

    }];

}
- (void)fetchOldData
{
    __weak RootViewController *weakSelf = self;
    //上拉加载
    [self.aTableView addRefreshFooterViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchOldWebData];
        [weakSelf.aTableView footerEndRefreshing];
    }];

}

#pragma mark - uitableView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    PianKeListCell *cell = [[self.aTableView visibleCells]firstObject];//当前可视界面中第一个cell
    
    if (cell == self.oldCell) {
        return;
    }
    //判断是不是上一个Cell
    self.oldCell = cell;//当前界面中第一个
    self.tmpColor = [UIColor randomcolor];
//    self.view.backgroundColor = _tmpColor;
    UIImage *image = [UIImage setBlurImage:cell.indexImageView.image quality:0.2 blurred:0.6] ;
    UIColor *backcolor = [UIColor colorWithPatternImage:image];
//    self.view.backgroundColor = backcolor;
    self.backImageView.image = image;
//    self.navigationController.navigationBar.barTintColor = _tmpColor;
    self.navigationController.navigationBar.barTintColor = backcolor;
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
    detail.backImage = self.backImageView.image;
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
    return self.dataKey;
}
- (NSMutableArray*)classifyArray
{
    if (_classifyArray == nil ) {
        _classifyArray = [NSMutableArray array];
        
    }
    return _classifyArray;
}
@end
