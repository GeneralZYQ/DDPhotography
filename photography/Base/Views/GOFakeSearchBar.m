//
//  GOFakeSearchBar.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 17/3/20.
//  Copyright © 2017年 KeyWenderman. All rights reserved.
//

#import "GOFakeSearchBar.h"

@implementation GOFakeSearchBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius = 4;
    self.backView.clipsToBounds = YES;
}
@end
