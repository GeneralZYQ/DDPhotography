//
//  DDOrderDetailViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrderDetailViewController.h"
#import "IDInlines.h"
#import "DDOrderDetailItemCell.h"

@interface DDOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DDOrder *order;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) UIButton *refuseButton;
@property (nonatomic, strong) UIButton *acceptButton;


@end

@implementation DDOrderDetailViewController

- (id)initWithOrder:(DDOrder *)order {
    self = [self init];
    if (self) {
        self.order = order;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.translucent = NO;

    
    self.titles = @[@"日期", @"时段", @"到达时间", @"项目类型", @"地点", @"项目名称", @"服务类型", @"客户", @"费用", @"电话", @"备注"];
    self.values = [NSMutableArray arrayWithObjects:@"2018-09-22", [XSInlines ensureNotNull:self.order.period], [XSInlines ensureNotNull:self.order.arrivalTime],  [XSInlines ensureNotNull:self.order.projectType], [XSInlines ensureNotNull:self.order.location], [XSInlines ensureNotNull:self.order.name], [XSInlines ensureNotNull:self.order.serviceType], [XSInlines ensureNotNull:self.order.customerName], [NSString stringWithFormat:@"%@", @(self.order.fee)], [XSInlines ensureNotNull:self.order.phone], [XSInlines ensureNotNull:self.order.script],nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), SNScreenBounds().size.height - 144) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if (self.order.isNew) {
        CGFloat interval = (viewWidth() - 240) / 3;
        self.refuseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.refuseButton.backgroundColor = [UIColor lightGrayColor];
        [self.refuseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
        self.refuseButton.frame = CGRectMake(interval, self.tableView.bottom + 20, 120, 40);
        [self.view addSubview:self.refuseButton];
        [self.refuseButton addTarget:self action:@selector(refuseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        self.acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.acceptButton.backgroundColor = [UIColor blueColor];
        [self.acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.acceptButton setTitle:@"接受" forState:UIControlStateNormal];
        self.acceptButton.frame = CGRectMake(self.refuseButton.right + interval, self.tableView.bottom + 20, 120, 40);
        [self.view addSubview:self.acceptButton];
        
    } else {
        self.tableView.frame = CGRectMake(0, 0, viewWidth(), SNScreenBounds().size.height);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DDOrderDetailItemCell"];
    if (!cell) {
        cell = [[DDOrderDetailItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DDOrderDetailItemCell"];
    }
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.detailLabel.text = self.values[indexPath.row];
    if ([cell.titleLabel.text isEqualToString:@"地点"]) {
        
    } else if ([cell.titleLabel.text isEqualToString:@"电话"]) {
        
    } else {
        
    }
    return cell;
}

- (void)refuseButtonPressed {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否拒绝该订单" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];[alert addAction:action2];
    [self presentViewController:alert animated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
