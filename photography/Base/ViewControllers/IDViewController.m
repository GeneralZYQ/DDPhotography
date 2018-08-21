//
//  IDViewController.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 17/2/26.
//  Copyright © 2017年 KeyWenderman. All rights reserved.
//

#import "IDViewController.h"
#import "Utility.h"
#import "IDInlines.h"
#import "UIImage+Tint.h"

@interface IDViewController ()

@end

@implementation IDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
        [item setTintColor:RGBCOLOR_HEX(0x4CAE65)];
        self.navigationItem.leftBarButtonItem = item;
    }
    
    self.view.backgroundColor = RGBCOLOR_HEX(0xf0f2f0);
}

- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)translucentNavigationBar {
    
    return NO;
}

- (void)checkTranslucent {
    
    if ([self translucentNavigationBar]) {
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        if (self.navigationController.viewControllers.count > 1) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"accessory"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
            [item setTintColor:RGBCOLOR_HEX(0x4CAE65)];
            self.navigationItem.leftBarButtonItem = item;
        }
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
