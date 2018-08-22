//
//  DDCustomerDetailViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDCustomerDetailViewController.h"
#import "CustomerItemObject.h"
#import "CustomerItemCell.h"

@interface DDCustomerDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Customer *customer;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation DDCustomerDetailViewController

- (id)initWithCustomer:(Customer *)customer {
    self = [self init];
    if (self) {
        self.customer = customer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), SNScreenBounds().size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerItemCell" bundle:nil]  forCellReuseIdentifier:@"CustomerItemCell"];
    [self.view addSubview:self.tableView];
    
    self.title = self.customer.name;
    
    self.items = [NSMutableArray arrayWithCapacity:0];
    
    CustomerItemObject *typeItem = [[CustomerItemObject alloc] init];
    typeItem.title = @"客户类型";
    typeItem.item = self.customer.customerType;
    
    CustomerItemObject *orderCountItem = [[CustomerItemObject alloc] init];
    orderCountItem.title = @"订单数";
    orderCountItem.item = [NSString stringWithFormat:@"%@单", @(self.customer.ordersCount)];
    
    CustomerItemObject *eranItem = [[CustomerItemObject alloc] init];
    eranItem.title = @"总金额";
    eranItem.item = [NSString stringWithFormat:@"¥%@", @(self.customer.earn)];
    
    CustomerItemObject *debitItem = [[CustomerItemObject alloc] init];
    debitItem.title = @"剩余欠款";
    debitItem.item = [NSString stringWithFormat:@"¥%@", @(self.customer.debit)];
    
    CustomerItemObject *n1 = [[CustomerItemObject alloc] init];
    n1.isNull = YES;
    
    CustomerItemObject *contactItem = [[CustomerItemObject alloc] init];
    contactItem.title = @"联系人";
    contactItem.item = [NSString stringWithFormat:@"%@", self.customer.contactName];
    contactItem.isLeft = YES;
    
    CustomerItemObject *phoneItem = [[CustomerItemObject alloc] init];
    phoneItem.title = @"电话";
    phoneItem.isLeft = YES;
    phoneItem.item = [NSString stringWithFormat:@"%@", self.customer.phone];
    phoneItem.icon = @"phone";
    
    CustomerItemObject *n2 = [[CustomerItemObject alloc] init];
    n2.isNull = YES;
    
    CustomerItemObject *recentItem = [[CustomerItemObject alloc] init];
    recentItem.title = @"近期订单";
    recentItem.isLeft = YES;
    recentItem.item = [NSString stringWithFormat:@"%@", self.customer.phone];
    recentItem.icon = @"rightArrow";
    
    [self.items addObject:typeItem];[self.items addObject:orderCountItem];[self.items addObject:eranItem];[self.items addObject:debitItem];[self.items addObject:n1];[self.items addObject:contactItem];[self.items addObject:phoneItem];[self.items addObject:n2];[self.items addObject:recentItem];
    
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerItemObject *objct = self.items[indexPath.row];
    if (objct.isNull) {
        return 10;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerItemCell *cusCell = [tableView dequeueReusableCellWithIdentifier:@"CustomerItemCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nullCell"];
    if (!cusCell) {
        cusCell = (CustomerItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"CustomerItemCell" owner:nil options:nil] lastObject];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nullCell"];
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    
    CustomerItemObject *obje = self.items[indexPath.row];
    if (obje.isNull) {
        return cell;
    } else {
        cusCell.item = obje;
        return cusCell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
