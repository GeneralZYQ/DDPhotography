//
//  DDEditCustomerController.m
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDEditCustomerController.h"
#import "CustomerEditItemCell.h"

@interface DDEditCustomerController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Customer *customer;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation DDEditCustomerController

- (id)initWithCustomer:(Customer *)customer {
    self = [self init];
    if (self) {
        self.customer = customer;
        self.items = [NSMutableArray arrayWithCapacity:0];
        
        CustomerEditItemObject *nameItem = [[CustomerEditItemObject alloc] init];
        nameItem.title = @"客户名称*";
        nameItem.currentValue = customer.name;
        nameItem.editType = EditTypeInput;
        
        CustomerEditItemObject *typeItem = [[CustomerEditItemObject alloc] init];
        typeItem.title = @"客户类型";
        typeItem.currentValue = customer.customerType;
        typeItem.editType = EditTypePicker;
        
        CustomerEditItemObject *nullItem = [[CustomerEditItemObject alloc] init];
        nullItem.isNull = YES;
        
        CustomerEditItemObject *contactItem = [[CustomerEditItemObject alloc] init];
        contactItem.title = @"联系人";
        contactItem.currentValue = customer.contactName;
        contactItem.editType = EditTypeInput;
        contactItem.icon = @"contact";
        
        CustomerEditItemObject *phoneItem = [[CustomerEditItemObject alloc] init];
        phoneItem.title = @"电话";
        phoneItem.currentValue = customer.phone;
        phoneItem.editType = EditTypeInput;
        
        [self.items addObject:nameItem];[self.items addObject:typeItem];[self.items addObject:nullItem];[self.items addObject:contactItem];[self.items addObject:phoneItem];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), SNScreenBounds().size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerEditItemCell" bundle:nil]  forCellReuseIdentifier:@"CustomerEditItemCell"];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(editCustomerItem)];
    self.navigationItem.rightBarButtonItem = editItem;

    // Do any additional setup after loading the view.
}

- (void)editCustomerItem {
    
    CustomerEditItemObject *nameItem = self.items[0];
    self.customer.name = nameItem.currentValue;
    
    CustomerEditItemObject *typeItem = self.items[1];
    self.customer.customerType = typeItem.currentValue;
    
    CustomerEditItemObject *contactItem = self.items[2];
    self.customer.contactName = contactItem.currentValue;
    
    CustomerEditItemObject *phoneItem = self.items[3];
    self.customer.phone = phoneItem.currentValue;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerEditItemObject *objct = self.items[indexPath.row];
    if (objct.isNull) {
        return 10;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomerEditItemCell *cusCell = [tableView dequeueReusableCellWithIdentifier:@"CustomerEditItemCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nullCell"];
    if (!cusCell) {
        cusCell = (CustomerEditItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"CustomerEditItemCell" owner:nil options:nil] lastObject];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nullCell"];
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    
    CustomerEditItemObject *obje = self.items[indexPath.row];
    if (obje.isNull) {
        return cell;
    } else {
        cusCell.editingItem = obje;
        return cusCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        CustomerEditItemObject *typeItem = self.items[1];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"婚礼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            typeItem.currentValue = @"婚礼";
        }];
        
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"宣传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            typeItem.currentValue = @"宣传";
        }];
        
        UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"活动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            typeItem.currentValue = @"活动";
        }];
        [alert addAction:act1];[alert addAction:act2];[alert addAction:act3];
        [self presentViewController:alert animated:YES completion:NULL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
