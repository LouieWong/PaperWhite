//
//  DetailViewController.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/26.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "DetailViewController.h"
#import "NetDataEngine.h"
#import "PaseBase.h"
#import <POP.h>
#import "DetailWebView.h"
#import "PaperButton.h"
#import "UMSocial.h"
@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic) DetailWebView *aWebView;
@property (nonatomic) PianKeDetailModel *pianKeIndexDetailModel;
@property (nonatomic) UIImageView *backImageView;
@property (nonatomic) NSArray *dataKey;
@property (nonatomic) PianKeDetailShareModel *pianKeDetailShareModel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self initUI];
    [self fetchData];
    
}
#pragma mark - 友盟
- (void)share
{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c7d51e0f55ac520001b94"
                                      shareText:[NSString stringWithFormat:@"我推荐了这篇文章:%@ \n%@\n %@",self.pianKeDetailShareModel.title,self.pianKeDetailShareModel.text, self.pianKeDetailShareModel.url]
                                     shareImage:self.pianKeDetailShareModel.pic
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToDouban,UMShareToRenren,nil]
                                       delegate:self];
    
}

#pragma mark - UIWebView
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
    //我不懂，但是我知道是调整webView里面的图片的,呵呵呵呵
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 320.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
- (void)loadString:(NSString*)str
{
    NSString *url = @"http://pianke.image.alimmdn.com/css/module.css?v=8292";
    [self.aWebView loadHTMLString:str baseURL:[NSURL URLWithString:url]];
//    [self.aWebView loadHTMLString:@"http://pianke.me/webview/5628fae95e7743526f8b4629" baseURL:[NSURL URLWithString:@"http://pianke.me/webview/5628fae95e7743526f8b4629"]];
}

#pragma mark - 搭建UI
- (void)config
{
    self.view.backgroundColor = [UIColor cyanGreenColor];
    self.backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.backImageView.clipsToBounds  = YES;
//    self.backImageView.backgroundColor = self.navigationController.navigationBar.barTintColor;
    [self.view addSubview:self.backImageView];
    self.backImageView.image = self.backImage;
    
}

- (void)initUI
{
    [self createUIWebView];
//    self.view.backgroundColor = self.navigationController.navigationBar.barTintColor;
    [self customNav];
}
- (void)createUIWebView
{
    self.aWebView = [DetailWebView UIWebView];
    _aWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
    _aWebView.backgroundColor = self.navigationController.navigationBar.barTintColor;
    _aWebView.delegate = self;
    [[[_aWebView subviews]objectAtIndex:0]setBounces:NO];
    [self.view addSubview:_aWebView];
}
- (void)customNav
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    
    PaperButton *button = [PaperButton button];
    [button addTarget:self action:@selector(animateTableView:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor whiteColor];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButton;
}
- (void)animateTableView:(id)sender
{
    
}

#pragma mark - 获取数据
- (void)fetchData {
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}
- (BOOL)fetchDataFromLocal {
    return NO;
}
- (void)fetchDataFromServer
{
    NSString *url = @"http://api2.pianke.me/article/info";
    NSDictionary *dic = @{@"contentid":self.pianKeIndexModel.id,@"limit":@(2)};
    
    [[NetDataEngine sharedInstance]requsetPianKeIndexDetailFrom:url parameters:dic success:^(id responsData) {
        NSLog(@"%@",responsData);
        self.dataKey = [PaseBase pasePianKeDetailData:responsData];
        PianKeDetailModel *model = self.dataKey[0];
        self.pianKeDetailShareModel = model.shareinfo;
        NSLog(@"%@",self.pianKeIndexDetailModel);
        [self loadString:model.html];
    } failed:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}
- (NSArray*)datakey
{
    if (self.dataKey == nil ) {
        self.dataKey = [NSArray array];
        
    }
    return _dataKey;
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
