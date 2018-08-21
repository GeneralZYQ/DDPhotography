//
//  IDTableViewController.h
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 16/9/13.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDURLRequestModel.h"
#import "IDObject.h"
#import "IDTableViewCell.h"
#import "UIView+sunny.h"
#import "AppDelegate.h"

@interface IDTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *sources; // 数据源

@property (nonatomic, assign) BOOL canRefresh;

- (void)parseModel:(IDURLRequestModel *)model;
- (void)createModel;

@end
