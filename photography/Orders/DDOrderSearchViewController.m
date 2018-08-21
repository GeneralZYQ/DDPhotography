//
//  DDOrderSearchViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrderSearchViewController.h"
#import "DDOrderCell.h"

@interface DDOrderSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *searchBack;
@property (nonatomic, weak) IBOutlet UITextField *field;
@property (nonatomic, strong) NSMutableArray *orders;

@end

@implementation DDOrderSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.orders = [NSMutableArray arrayWithCapacity:0];
    self.navigationController.navigationBarHidden = YES;
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.searchBack.layer.cornerRadius = self.searchBack.frame.size.height / 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"DDOrderCell"];
    if (!orderCell) {
        orderCell = [[DDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DDOrderCell"];
    }
    orderCell.order = self.orders[indexPath.row];
    return orderCell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    // 开始搜索
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
