//
//  DDLoginViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/13.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDLoginViewController.h"
#import "IDConfig.h"

@interface DDLoginViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *phoneField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;

@end

@implementation DDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneField.delegate = self;
    self.passwordField.delegate = self;
    self.doneButton.enabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.passwordField resignFirstResponder];
    [self.phoneField resignFirstResponder];
}

- (IBAction)eyeButtonPressed:(id)sender {
    self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
}

- (IBAction)doneButtonPressed:(id)sender {
#ifdef DEBUG
    if ([self.passwordField.text isEqualToString:@"1234"] && [self.phoneField.text isEqualToString:@"13500000000"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
        [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"kUserID"];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
#endif
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL doenenable = NO;
    
    if (self.phoneField.text.length && self.passwordField.text.length) {
        doenenable = YES;
    }
    
    if (range.length >= textField.text.length && string.length <= 0) {
        doenenable = NO;
    }
    
    self.doneButton.enabled = doenenable;
    
    return YES;
}

@end
