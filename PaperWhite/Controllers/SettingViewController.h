//
//  SettingViewController.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/10/25.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PulldownMentuDelegate
- (void)menuitemSelected:(NSIndexPath*)indexPath;
- (void)pullDownAnimated:(BOOL)open;
@end
@interface SettingViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    id<PulldownMentuDelegate>pulldelegate;
}
@property (nonatomic, retain) id<PulldownMentuDelegate> pulldelegate;
@property (nonatomic,strong) NSMutableArray *tableViewArray;
@property (nonatomic,strong) NSString *cellString;

-(NSString *) cellString;
@end
