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
@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic) DetailWebView *aWebView;
@property (nonatomic) PianKeIndexDetailModel *pianKeIndexDetailModel;


@property (nonatomic)NSArray *dataKey;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self fetchData];
    
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
}
#pragma mark - 搭建UI
- (void)initUI
{
    [self createUIWebView];
    self.view.backgroundColor = self.navigationController.navigationBar.barTintColor;
}
- (void)createUIWebView
{
    self.aWebView = [DetailWebView UIWebView];
    _aWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
    _aWebView.backgroundColor = self.navigationController.navigationBar.barTintColor;
    _aWebView.delegate = self;
    [self.view addSubview:_aWebView];
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
        self.dataKey = [PaseBase pasePianKeListDetailData:responsData];
        PianKeIndexDetailModel *model = self.dataKey[0];
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
