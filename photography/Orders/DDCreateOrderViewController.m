//
//  DDCreateOrderViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDCreateOrderViewController.h"
#import "DDCreateOrderItemView.h"
#import "IDInlines.h"
#import "UIView+sunny.h"
#import "DDDatePicker.h"

@interface DDCreateOrderViewController ()

@property (nonatomic, strong) UIScrollView *backScroll;
@property (nonatomic, strong) NSMutableArray<DDCreateOrderItemView *> *items;
@property (nonatomic, strong) DDDatePicker *datePicker;
@property (nonatomic, strong) DDDatePicker *arrivalPicker;

@end

@implementation DDCreateOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), SNScreenBounds().size.height - 64)];
    [self.view addSubview:self.backScroll];
    self.backScroll.contentSize = CGSizeMake(viewWidth(), 44 * 11);
    self.backScroll.backgroundColor = [UIColor whiteColor];
    
    self.items = [NSMutableArray arrayWithCapacity:0];
    
    DDCreateOrderItemView *dateView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeDate icon:@"" frame:CGRectMake(0, 0, viewWidth(), 44)];
    dateView.titleLabel.text = @"日期";
    [dateView.detailButton setTitle:@"请选择日期" forState:UIControlStateNormal];
    [dateView.detailButton addTarget:self action:@selector(datePickerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.items addObject:dateView];
    
    DDCreateOrderItemView *periodView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeMultiChoice icon:@"" frame:CGRectMake(0, dateView.bottom, viewWidth(), 44)];
    periodView.titleLabel.text = @"时段";
    [self.items addObject:periodView];
    
    DDCreateOrderItemView *arrivalView = [[DDCreateOrderItemView alloc] initWithType:ItemTypePicker icon:@"" frame:CGRectMake(0, periodView.bottom, viewWidth(), 44)];
    arrivalView.titleLabel.text = @"到达时间";
    [arrivalView.detailButton setTitle:@"请选择时间" forState:UIControlStateNormal];
    [arrivalView.detailButton addTarget:self action:@selector(timePeriodButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.items addObject:arrivalView];
    
    DDCreateOrderItemView *proTypeView = [[DDCreateOrderItemView alloc] initWithType:ItemTypePicker icon:@"" frame:CGRectMake(0, arrivalView.bottom, viewWidth(), 44)];
    proTypeView.titleLabel.text = @"项目类型";
    [proTypeView.detailButton setTitle:@"请选择类型" forState:UIControlStateNormal];
    [proTypeView.detailButton addTarget:self action:@selector(projectTypeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.items addObject:proTypeView];
    
    DDCreateOrderItemView *locationView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeInput icon:@"" frame:CGRectMake(0, proTypeView.bottom, viewWidth(), 44)];
    locationView.titleLabel.text = @"地点";
    locationView.placeHolder = @"请输入地点";
    [self.items addObject:locationView];
    
    DDCreateOrderItemView *proNameView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeInput icon:@"" frame:CGRectMake(0, locationView.bottom, viewWidth(), 44)];
    proNameView.titleLabel.text = @"项目名称";
    proNameView.placeHolder = @"请输入项目名称";
    [self.items addObject:proNameView];
    
    DDCreateOrderItemView *serviceTypeView = [[DDCreateOrderItemView alloc] initWithType:ItemTypePicker icon:@"" frame:CGRectMake(0, proNameView.bottom, viewWidth(), 44)];
    serviceTypeView.titleLabel.text = @"服务类型";
    [serviceTypeView.detailButton setTitle:@"请选择服务类型" forState:UIControlStateNormal];
    [serviceTypeView.detailButton addTarget:self action:@selector(serviceTypeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.items addObject:serviceTypeView];
    
    DDCreateOrderItemView *customerView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeInput icon:@"" frame:CGRectMake(0, serviceTypeView.bottom, viewWidth(), 44)];
    customerView.titleLabel.text = @"客户";
    customerView.placeHolder = @"请输入客户姓名";
    [self.items addObject:customerView];
    
    DDCreateOrderItemView *phoneView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeInput icon:@"" frame:CGRectMake(0, customerView.bottom, viewWidth(), 44)];
    phoneView.titleLabel.text = @"电话";
    phoneView.placeHolder = @"请输入客户电话";
    [self.items addObject:phoneView];
    
    DDCreateOrderItemView *feeView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeInput icon:@"" frame:CGRectMake(0, phoneView.bottom, viewWidth(), 44)];
    feeView.titleLabel.text = @"费用";
    feeView.placeHolder = @"请输入费用";
    [self.items addObject:feeView];
    
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, feeView.bottom, viewWidth(), 10)];
    [self.items addObject:sep];
    sep.backgroundColor = [UIColor lightGrayColor];
    
    DDCreateOrderItemView *commentView = [[DDCreateOrderItemView alloc] initWithType:ItemTypeInput icon:@"" frame:CGRectMake(0, sep.bottom, viewWidth(), 44)];
    commentView.titleLabel.text = @"备注";
    commentView.placeHolder = @"请输入备注";
    [self.items addObject:commentView];
//    [periodView.detailButton setTitle:@"" forState:<#(UIControlState)#>]
    
    for (int i = 0; i < 12; i++) {
        UIView *view = self.items[i];
        [_backScroll addSubview:view];
    }
    
    self.datePicker = [[DDDatePicker alloc] initWithFrame:self.view.bounds doneBlock:^(NSDate *date) {
        DDCreateOrderItemView *dateView = self.items[0];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年MM月dd日";
        NSString *formstring = [formatter stringFromDate:date];
        [dateView.detailButton setTitle:formstring forState:UIControlStateNormal];
    } type:UIDatePickerModeDate];
    
    self.arrivalPicker = [[DDDatePicker alloc] initWithFrame:self.view.bounds doneBlock:^(NSDate *date) {
        DDCreateOrderItemView *dateView = self.items[2];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年MM月dd日";
        NSString *formstring = [formatter stringFromDate:date];
        [dateView.detailButton setTitle:formstring forState:UIControlStateNormal];
    } type:UIDatePickerModeCountDownTimer];
}

- (void)datePickerButtonPressed {
    
    [self.view addSubview:self.datePicker];
}

- (void)timePeriodButtonPressed {
    [self.view addSubview:self.arrivalPicker];
}

- (void)projectTypeButtonPressed {
    DDCreateOrderItemView *dateView = self.items[3];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"婚礼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"婚礼" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"宣传片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"宣传片" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac3 = [UIAlertAction actionWithTitle:@"活动会议" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"活动会议" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac4 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"其他" forState:UIControlStateNormal];
    }];
    [alertVC addAction:ac1];[alertVC addAction:ac2];[alertVC addAction:ac3];[alertVC addAction:ac4];
    [self presentViewController:alertVC animated:YES completion:NULL];
}

- (void)serviceTypeButtonPressed {
    
    DDCreateOrderItemView *dateView = self.items[6];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"摄影师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"摄影师" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"摄像师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"摄像师" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac3 = [UIAlertAction actionWithTitle:@"导播" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"导播" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac4 = [UIAlertAction actionWithTitle:@"航拍" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"航拍" forState:UIControlStateNormal];
    }];
    UIAlertAction *ac5 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [dateView.detailButton setTitle:@"其他" forState:UIControlStateNormal];
    }];
    [alertVC addAction:ac1];[alertVC addAction:ac2];[alertVC addAction:ac3];[alertVC addAction:ac4];[alertVC addAction:ac5];
    [self presentViewController:alertVC animated:YES completion:NULL];
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
