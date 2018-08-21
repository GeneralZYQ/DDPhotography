//
//  FirstViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/13.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "FirstViewController.h"
#import "IDConfig.h"
#import "DDIntroViewController.h"
#import "DDOrderDateView.h"
#import "DDOrderTopView.h"
#import "DDOrderCell.h"
#import "DDOrderDetailViewController.h"
#import "DDOrderSearchViewController.h"
#import "DDMessagesViewController.h"
#import "DDCreateOrderViewController.h"

@interface FirstViewController () <DDOrderTopViewDelegate, DDOrderDateViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DDOrderTopView *topView;
@property (nonatomic, strong) DDOrderDateView *dateView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    self.datas = [NSMutableArray arrayWithCapacity:0];
    
#warning 测试数据
    DDOrder *o1 = [[DDOrder alloc] init];
    o1.name = @"百乐门宣传片";
    o1.status = OrderStatusToConfirm;
    
    DDOrder *o2 = [[DDOrder alloc] init];
    o2.name = @"大上海宣传片";
    o2.status = OrderStatusTodo;
    
    DDOrder *o3 = [[DDOrder alloc] init];
    o3.name = @"大上海宣传片";
    o3.status = OrderStatusToConfirm;
    
    self.datas = [NSMutableArray arrayWithCapacity:0];
    [self.datas addObject:@[o1, o2]];
    [self.datas addObject:@[o3]];
    
    
    self.dateView = [[DDOrderDateView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 64)];
    [self.view addSubview:self.dateView];
    self.dateView.delegate = self;
    [self.dateView reloadWithMonthCount:6];
    
    self.topView = [[DDOrderTopView alloc] initWithFrame:CGRectMake(0, 64, viewWidth(), 60)];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, viewWidth(), SNScreenBounds().size.height - self.topView.bottom - 44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:[DDOrderCell class] forCellReuseIdentifier:@"DDOrderCell"];
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kUserID].length <= 0) {
        DDIntroViewController *introVC = [[DDIntroViewController alloc] initWithNibName:@"DDIntroViewController" bundle:nil];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:introVC];
        [self presentViewController:navi animated:YES completion:NULL];
    }
}


#pragma mark - DDOrderTopViewDelegate

- (void)orderTopViewAddButtonPressed {
    DDCreateOrderViewController *createVC = [[DDCreateOrderViewController alloc] init];
    createVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:createVC animated:YES];
}

- (void)orderTopViewDoneButtonPressed {
    
    DDOrder *o1 = [[DDOrder alloc] init];
    o1.name = @"百乐门宣传片";
    o1.period = @"下午";
    o1.arrivalTime = @"晚上10点";
    o1.projectType = @"宣传片";
    o1.location = @"百乐门夜总会";
    o1.serviceType = @"摄像师";
    o1.customerName = @"顾连成";
    o1.fee = 6000;
    o1.phone = @"021xxxxx";
    o1.script = @"好好拍";
    o1.status = OrderStatusDone;
    
    DDOrder *o2 = [[DDOrder alloc] init];
    o2.name = @"大上海宣传片";
    o2.status = OrderStatusDone;
    
    DDOrder *o3 = [[DDOrder alloc] init];
    o3.name = @"大上海宣传片";
    o3.status = OrderStatusRejected;
    
    self.datas = [NSMutableArray arrayWithCapacity:0];
    [self.datas addObject:@[o1, o2]];
    [self.datas addObject:@[o3]];
    [self.tableView reloadData];
}

- (void)orderTopViewTodoButtonPressed {
    
    DDOrder *o1 = [[DDOrder alloc] init];
    o1.name = @"百乐门宣传片";
    o1.period = @"下午";
    o1.arrivalTime = @"晚上10点";
    o1.projectType = @"宣传片";
    o1.location = @"百乐门夜总会";
    o1.serviceType = @"摄像师";
    o1.customerName = @"顾连成";
    o1.fee = 6000;
    o1.phone = @"021xxxxx";
    o1.script = @"好好拍";
    o1.status = OrderStatusToConfirm;
    
    DDOrder *o2 = [[DDOrder alloc] init];
    o2.name = @"大上海宣传片";
    o2.status = OrderStatusTodo;
    
    DDOrder *o3 = [[DDOrder alloc] init];
    o3.name = @"大上海宣传片";
    o3.status = OrderStatusToConfirm;
    
    self.datas = [NSMutableArray arrayWithCapacity:0];
    [self.datas addObject:@[o1, o2]];
    [self.datas addObject:@[o3]];
    [self.tableView reloadData];
}

- (void)orderTopViewSearchButtonPressed {
    DDOrderSearchViewController *searchVC = [[DDOrderSearchViewController alloc] initWithNibName:@"DDOrderSearchViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self.navigationController presentViewController:navi animated:YES completion:NULL];
}

#pragma mark - DDOrderDateViewDelegate

- (void)orderDateViewMessageButtonPressed {
    DDMessagesViewController *messageVC = [[DDMessagesViewController alloc] init];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.datas[section];
    return arr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), 20)];
    header.backgroundColor = [UIColor lightGrayColor];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 20, 14)];
    [header addSubview:dateLabel];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"DDOrderCell"];
    if (!orderCell) {
        orderCell = [[DDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DDOrderCell"];
    }
    orderCell.order = self.datas[indexPath.section][indexPath.row];
    return orderCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrder *order = self.datas[indexPath.section][indexPath.row];
    DDOrderDetailViewController *detailVC = [[DDOrderDetailViewController alloc] initWithOrder:order];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
