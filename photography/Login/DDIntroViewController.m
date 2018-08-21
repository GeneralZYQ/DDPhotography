//
//  DDIntroViewController.m
//  photography
//
//  Created by 张元清 on 2018/8/13.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDIntroViewController.h"
#import "DDSignViewController.h"
#import "DDLoginViewController.h"

@interface DDIntroViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) IBOutlet UIButton *signButton;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation DDIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(), SNScreenBounds().size.height - 80)];
    _scroll.contentSize = CGSizeMake(viewWidth() * 3, _scroll.height);
    _scroll.pagingEnabled = YES;
    [self.view addSubview:_scroll];
    self.navigationController.navigationBarHidden = YES;
    
    self.images = [NSMutableArray arrayWithCapacity:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.images.count <= 0) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth() * i, 0, viewWidth(), SNScreenBounds().size.height - 80)];
            [_scroll addSubview:imageView];
            [self.images addObject:imageView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginbuttonpressed:(id)sender{
    DDLoginViewController *loginVC = [[DDLoginViewController alloc] initWithNibName:@"DDLoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}

-(IBAction)signbuttonpressed:(id)sender {
    DDSignViewController *signVC = [[DDSignViewController alloc] initWithNibName:@"DDSignViewController" bundle:nil];
    [self.navigationController pushViewController:signVC animated:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
}

@end
