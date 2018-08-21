//
//  DDCustomersController.m
//  photography
//
//  Created by 张元清 on 2018/8/21.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDCustomersController.h"
#import "DDCustomerButton.h"
#import "DDCustomerFilterView.h"
#import "DDCustomerFilterConditonView.h"

@interface DDCustomersController ()<UIScrollViewDelegate, DDCustomerFilterViewDelegate>

@property (nonatomic, strong) UIScrollView *backScroll;
@property (nonatomic, strong) DDCustomerFilterView *filterView;
@property (nonatomic, strong) NSMutableArray *customers;

@end

@implementation DDCustomersController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 需要获取customer的数量
    self.customers = [NSMutableArray arrayWithCapacity:0];
    
    self.filterView = [[DDCustomerFilterView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 40)];
    [self.view addSubview:self.filterView];
    self.filterView.delegate = self;
    
    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, viewWidth(), SNScreenBounds().size.height - 64 -55 -40)];
    
    
    NSInteger allLines = floor(self.customers.count / 3.0);
    NSInteger pageCapicity = ceil(self.backScroll.height / 110.0);
    NSInteger pages = floor(allLines / pageCapicity);
    CGFloat buttonWidth = viewWidth() / 3;
    CGFloat buttonHeight = 110;
    
    self.backScroll.contentSize = CGSizeMake(viewWidth() * pages, self.backScroll.height);
    self.backScroll.delegate = self;
    [self.view addSubview:self.backScroll];
    
    for (int i = 0; i< self.customers.count; i++) {
        NSInteger beginInterval = i / pageCapicity;
        
        DDCustomerButton *cusButton = [[DDCustomerButton alloc] initWithFrame:CGRectMake(beginInterval + (i - beginInterval * pageCapicity) % 3, (i - beginInterval * pageCapicity) / 3, buttonWidth, buttonHeight)];
//        cusButton.customer = self.customers[i];
        cusButton.customer = self.customers[i];
        cusButton.tag = i;
        [self.backScroll addSubview:cusButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DDCustomerFilterViewDelegate

- (void)customerDidSearchName:(NSString *)name {
    
}
- (void)customerDidPressFilterButton {
    
}
- (void)customerDidPressAddButton {
    
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
