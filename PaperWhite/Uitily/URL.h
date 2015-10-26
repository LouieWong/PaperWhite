//
//  URl.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#ifndef FirstApp_URl_h
#define FirstApp_URl_h

#pragma mark - 阅读Url
//知乎日报首页
#define kIndexUrl @"http://news-at.zhihu.com/api/4/stories/latest"
//详情页面
#define kDetailUrl @"http://news-at.zhihu.com/api/4/story/%@"
//详情评论数据页面
#define kDetailExtraUrl @"http://news-at.zhihu.com/api/4/story-extra/%@"
//长评
#define kLongCommentsUrl @"http://news-at.zhihu.com/api/4/story/%@/long-comments"
//短评
#define kShortCommentsUrl @"http://news-at.zhihu.com/api/4/story/%@/short-comments"
//往期内容
#define kOldIndexUrl @"http://news-at.zhihu.com/api/4/stories/before/%@"
//分类
#define kAssortmentUrl @"http://news-at.zhihu.com/api/4/themes"
//分类数据
#define kAssortmentDataUrl @"http://news-at.zhihu.com/api/4/theme/%d"
//分类往期内容
#define kAssortmentOldDataUrl @"http://news-at.zhihu.com/api/4/theme/%d/before/%@"

#pragma mark - 动画Url
//首页
#define kVideoIndexUrl @"http://i.animetaste.net/api/setup/?api_key=android&timestamp=1444269739&anime=20&feature=5&advert=2&access_token=7039a390df64e669442c1cdde9b81b42"


//加载更多
#define kVideoIndexOldUrl @"http://i.animetaste.net/api/animelist_v4/?api_key=android&timestamp=1444270424&page=%d&access_token=364157ec56e8a70d15686c70b62d0dd6"


//详情页面的 相关推荐 数据

#define kVideoDetailUrl @"http://i.animetaste.net/api/animelist_v4/?api_key=android&timestamp=1444270620&order=random&limit=5&access_token=ce7efa48e232913216c85cb7f54c00d3"
//参数 设置
//order = random
//随机刷5条数据
//不需要修改参数
//
#define kVideoRandomTenIndexOldUrl @"http://i.animetaste.net/api/animelist_v4/?api_key=android&timestamp=1444270908&order=random&limit=10&access_token=33f2ce36c32bfa4b8be8c8255ef3b1a5"
//猜你喜欢 刷新10条数据
//
//分类
//http://i.animetaste.net/api/animelist_v4/?api_key=android&timestamp=1444271161&category=1&feature=1&limit=4&access_token=761132ddd57641cc51111c9e2986d009
//
//category 参数 不同分类
//顶部刷新 scroll滚动推荐
//
//分类 表格数据
//http://i.animetaste.net/api/animelist_v4/?api_key=android&timestamp=1444271782&page=1&category=2&limit=10&access_token=784fb6473e59993cb4c891c3ea87afd5
//
//page 页码 一页10条数据
//category 参数 分类
//limit = 10写死 不能修改

#endif
