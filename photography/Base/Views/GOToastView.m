//
//  GOToastView.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 17/2/14.
//  Copyright © 2017年 KeyWenderman. All rights reserved.
//

#import "GOToastView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"

@implementation GOToastView

+ (void)showToastWithImageName:(NSString *)name text:(NSString *)text {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.tintColor = [UIColor whiteColor];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.contentColor = [UIColor whiteColor];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.label.text = text;
    hud.label.textColor = [UIColor whiteColor];
    
    [hud hideAnimated:YES afterDelay:1.f];
}

@end
