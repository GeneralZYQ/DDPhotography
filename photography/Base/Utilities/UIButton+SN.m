//
//  UIButton+SN.m
//  SpeakOut
//
//  Created by sunny on 15-2-11.
//  Copyright (c) 2015年 51tallk. All rights reserved.
//

#import "UIButton+SN.h"
#import <objc/runtime.h>
#import "UIImage+Tint.h"
#import "IDInlines.h"

//static char kHighlightBackgroundColorKey;

@implementation UIButton (SN)

+ (void)load {
    
    // 把initWithframe替换一下
    SwizzleClassMethod([self class],@selector(initWithFrame:), @selector(snInitWithFrame:), NO);
}

- (id)snInitWithFrame:(CGRect)frame {
    UIButton *button = [self snInitWithFrame: frame];
    if (button) {
        
        // 设置所有button智能同时有一个被选中
        button.exclusiveTouch = YES;
    }
    return button;
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *colorImage = [[UIImage imageWithColor:color andSize:CGSizeMake(1, 1)] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    [self setBackgroundImage:colorImage forState:state];
}

//- (void)setHighlightBackgroundColor:(UIColor *)highlightBackgroundColor {
//    if (!CGColorEqualToColor(self.highlightBackgroundColor.CGColor, highlightBackgroundColor.CGColor)) {
//        objc_setAssociatedObject(self, &kHighlightBackgroundColorKey, highlightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        [self setBackgroundColor:highlightBackgroundColor forState:UIControlStateHighlighted];
//    }
//}
//
//- (UIColor *)highlightBackgroundColor {
//    return objc_getAssociatedObject(self, &kHighlightBackgroundColorKey);
//}

@end
