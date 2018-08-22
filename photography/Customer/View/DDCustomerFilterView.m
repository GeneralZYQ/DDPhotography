//
//  DDCustomerFilterView.m
//  photography
//
//  Created by 张元清 on 2018/8/21.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDCustomerFilterView.h"
#import "UIView+sunny.h"

@implementation DDCustomerFilterView {
    UITextField *_textFiled;
    UIButton *_filterButton;
    UIButton *_addButton;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, 5, self.width - 120, 30)];
        _textFiled.layer.cornerRadius = 15;
        _textFiled.layer.borderColor = [UIColor blueColor].CGColor;
        _textFiled.layer.borderWidth = 0.5;
        _textFiled.placeholder = @"请输入想要查找的内容";
        [self addSubview:_textFiled];
        
        _filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _filterButton.frame = CGRectMake(_textFiled.right + 10, 5, 30, 30);
        [_filterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:_filterButton];
        [_filterButton setTitle:@"F" forState:UIControlStateNormal];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(_filterButton.right + 10, 5, 30, 30);
        [self addSubview:_addButton];
        [_addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
    }
    return self;
}

- (void)filterButtonPressed {
    if ([self.delegate respondsToSelector:@selector(customerDidPressFilterButton)]) {
        [self.delegate customerDidPressFilterButton];
    }
}

- (void)addButtonPressed {
    if ([self.delegate respondsToSelector:@selector(customerDidPressAddButton)]) {
        [self.delegate customerDidPressAddButton];
    }
}

@end
