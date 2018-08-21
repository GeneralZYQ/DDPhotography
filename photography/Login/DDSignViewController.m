//
//  DDSignViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/13.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDSignViewController.h"

@interface DDSignViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *phoneField;
@property (nonatomic, weak) IBOutlet UITextField *testifyFiled;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UIButton *getCodeButton;
@property (nonatomic, weak) IBOutlet UIButton *eyeButton;

@end

@implementation DDSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.phoneField.delegate = self;
    self.testifyFiled.delegate = self;
    self.passwordField.delegate = self;
    self.passwordField.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL shouldEn = YES;
    
    if (self.phoneField.text.length && self.testifyFiled.text.length && self.passwordField.text.length) {
        shouldEn = YES;
    }
    
    if (range.length >= textField.text.length && string.length <= 0) {
        shouldEn = NO;
    }
    
    self.nextButton.userInteractionEnabled = shouldEn;
    
    return YES;
}

- (IBAction)eyeButtonPressed:(id)sender {
    
    self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
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
