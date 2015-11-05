//
//  SettingController.h
//  PaperWhite
//
//  Created by qianfeng001 on 15/11/3.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pulldownMentuDelegate
- (void)menuitemSelected:(NSIndexPath*)indexPath;
- (void)pullDownAnimated:(BOOL)open;
@end
@interface SettingController : UIViewController


@end
