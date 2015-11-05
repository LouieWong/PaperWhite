//
//  SettingController.m
//  PaperWhite
//
//  Created by qianfeng001 on 15/11/3.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *aTableView;
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI
{
    self.aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 100) style:UITableViewStylePlain];
    self.aTableView.dataSource = self;
    self.aTableView.delegate = self;
    [self.view addSubview:self.aTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    return cell;
}

@end