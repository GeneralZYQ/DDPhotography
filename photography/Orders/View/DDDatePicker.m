//
//  DDDatePicker.m
//  photography
//
//  Created by 张元清 on 2018/8/19.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDDatePicker.h"
#import "UIView+sunny.h"

@implementation DDDatePicker {
//    ^(void)(NSDate *) *doneblock;
    doneBlock _ddblock;
    UIButton *_cancelButton;
    UIButton *_doneButton;
    UIDatePicker *_datePicker;
}

- (id)initWithFrame:(CGRect)frame doneBlock:(doneBlock)eblock type:(UIDatePickerMode)type {
    if (self = [self initWithFrame:frame]) {
        _ddblock = eblock;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 140, self.width, 140)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(10, 10, 40, 20);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [backView addSubview:_cancelButton];
        
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.frame = CGRectMake(self.width - 50, 10, 40, 20);
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [backView addSubview:_doneButton];
        
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _cancelButton.bottom + 10, self.width, 100)];
        _datePicker.datePickerMode = type;
        [_datePicker setDate:[NSDate date] animated:NO];
        [backView addSubview:_datePicker];
    }
    return self;
}

- (void)cancelButtonPressed {
    [self removeFromSuperview];
    
}

- (void)doneButtonPressed {
    
    _ddblock(_datePicker.date);
    [self removeFromSuperview];
}

@end
