//
//  GOClassicButton.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 17/3/18.
//  Copyright © 2017年 KeyWenderman. All rights reserved.
//

#import "GOClassicButton.h"
#import "Utility.h"

@implementation GOClassicButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:RGBCOLOR_HEX(0x4CAE65)];
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
