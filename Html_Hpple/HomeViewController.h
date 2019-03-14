//
//  HoneViewController.h
//  Html_Hpple
//
//  Created by wangan on 13-4-12.
//  Copyright (c) 2013年 com.wangan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UITableViewController


@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *contArray;
@property (strong, nonatomic) NSArray *array;


-(void)initData;
//解析Title
-(NSMutableArray *)AnalyticalTitle:(NSString *)htmlString;
//解析图片
-(NSMutableArray *)AnalyticalImage:(NSString *)htmlString;
//解析内容
-(NSMutableArray *)AnalyticalCont:(NSString *)htmlString;
@end
