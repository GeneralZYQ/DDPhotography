//
//  DDCustomerButton.m
//  photography
//
//  Created by 张元清 on 2018/8/21.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDCustomerButton.h"

@implementation DDCustomerButton {
    UILabel *_typeLabel;
    UILabel *_nameLabel;
    UILabel *_countLabel;
    UIImageView *_ratingStar;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 15, 40)];
        _typeLabel.numberOfLines = 0;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_typeLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _typeLabel.bottom + 10, self.width, 15)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _nameLabel.bottom + 5, self.width, 15)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
        
        _ratingStar = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 40, self.height - 40, 30, 30)];
        [self addSubview:_ratingStar];
    }
    return self;
}

- (void)setCustomer:(DDCustomer *)customer {
    _customer = customer;
    _typeLabel.text = customer.customerType;
    _nameLabel.text = customer.name;
    _countLabel.text = [NSString stringWithFormat:@"%@", @(customer.ordersCount)];
//    _ratingStar.image //决定于rating大小的一张图片
}

@end
