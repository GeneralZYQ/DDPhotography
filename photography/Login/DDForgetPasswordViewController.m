//
//  DDForgetPasswordViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/15.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDForgetPasswordViewController.h"

@interface DDForgetPasswordViewController ()

@property (nonatomic, weak) IBOutlet UITextField *numberField;
@property (nonatomic, weak) IBOutlet UITextField *testifyFiled;
@property (nonatomic, weak) IBOutlet UIButton *getTestifyButton;
@property (nonatomic, weak) IBOutlet UITextField *paswordField;
@property (nonatomic, weak) IBOutlet UITextField *confirmPaswordFiled;
@property (nonatomic, weak) IBOutlet UIButton *eyeButton;
@property (nonatomic, weak) IBOutlet UIButton *confirmEyeButton;

@end

@implementation DDForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additzional setup after loading the view from its nib.
    self.title = @"找回密码";
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
