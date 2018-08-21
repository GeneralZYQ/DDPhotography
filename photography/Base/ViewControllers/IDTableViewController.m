//
//  IDTableViewController.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 16/9/13.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDTableViewController.h"
#import <MJRefresh.h>
#import "IDURLRequestModel.h"
#import "IDObject.h"
#import "IDTableViewCell.h"
//#import "IDDModel.h"

@interface IDTableViewController ()

@property (nonatomic, strong) MJRefreshNormalHeader *loadingHeader; // 下啦刷新控件
@property (nonatomic, strong) MJRefreshAutoFooter *loadMoreFooter; // 上拉加载更多控件
@property (nonatomic, strong) IDURLRequestModel *tableViewModel; // model


@end

@implementation IDTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        self.canRefresh = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sources = [NSMutableArray arrayWithCapacity:0];
    
    [self createModel];
    
    if (self.canRefresh) {
        
        self.loadingHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefreshing)];
        self.tableView.mj_header = self.loadingHeader;
        
        
        self.loadMoreFooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(startLoadingMore)];
        self.tableView.mj_footer = self.loadMoreFooter;
        
        [self.loadingHeader beginRefreshing];
    } else {
        
        [self.tableViewModel load:0 more:NO];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = RGBCOLOR_HEX(0xf0f0f0);
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
        [item setTintColor:RGBCOLOR_HEX(0x4CAE65)];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createModel {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRefreshing {
    
    if (!self.tableViewModel.isLoading) {
        [self.tableViewModel load:0 more:NO];
    }
}

- (void)startLoadingMore {
    
    if (!self.tableViewModel.isLoading) {
        [self.tableViewModel load:0 more:YES];
    }
}

- (void)parseModel:(IDURLRequestModel *)model {
    
}

- (void)cellDidTappedAtIndex:(NSIndexPath *)indexPath object:(IDObject *)object {
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataSection = _sources[section];
    return dataSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IDObject *object = [[_sources objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    IDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([object cellClass])];
    if (!cell) {
        cell = [[[object cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([object cellClass])];
    }
    [cell updateCellWithObject:object];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IDObject *object = [[_sources objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self cellDidTappedAtIndex:indexPath object:object];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IDObject *obj = [[_sources objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return [obj height];
//    return 40;
}

- (void)modelDidStartLoad:(IDURLRequestModel *)model {
    
    
}

- (void)modelDidFinishLoad:(IDURLRequestModel *)model withObject:(id)object {
    
    [self.loadingHeader endRefreshing];
    [self parseModel:model];
    [self.tableView reloadData];
}

- (void)model:(IDURLRequestModel *)model didFailLoadWithError:(NSError *)error {
    
    [self.loadingHeader endRefreshing];
}

@end
