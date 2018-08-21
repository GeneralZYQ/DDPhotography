//
//  IDNetworkViewController.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 16/9/16.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDNetworkViewController.h"


@interface IDNetworkViewController ()

@property (nonatomic, strong) IDURLRequestModel *model;

@end

@implementation IDNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createModel];
    [self.model load:0 more:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createModel {
    
    
}

- (void)parseHttpResponse:(id)httpObject withModel:(IDURLRequestModel *)model {
    
    
}

@end
