//
//  UIButton+SN.h
//  SpeakOut
//
//  Created by sunny on 15-2-11.
//  Copyright (c) 2015年 51tallk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SN)

//@property (nonatomic, strong) UIColor *highlightBackgroundColor;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end
