//
//  DDPersonalInfoViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/15.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDPersonalInfoViewController.h"

@interface DDPersonalInfoViewController ()

@property (nonatomic, weak) IBOutlet UIButton *avatarButton;
@property (nonatomic, weak) IBOutlet UIButton *careerButton;
@property (nonatomic, weak) IBOutlet UIButton *regionButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UITextField *nameField;

@end

@implementation DDPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善个人信息";
    // Do any additional setup after loading the view from its nib.
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
