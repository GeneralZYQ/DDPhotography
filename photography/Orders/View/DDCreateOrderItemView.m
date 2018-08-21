//
//  DDCreateOrderItemView.m
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDCreateOrderItemView.h"
#import "UIView+sunny.h"
#import "IDInlines.h"

@implementation DDCreateOrderItemView {
    UITextField *_inputField;
}

- (id)initWithType:(ItemType)type icon:(NSString *)icon frame:(CGRect)frame {
    self = [self initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 60, 15)];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titleLabel];
        
        self.nessaceryTag  = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.right, self.titleLabel.top, 5, 5)];
        [self addSubview:self.nessaceryTag];
        
        if (ItemTypeDate == type || ItemTypeInput == type) {
            
            _inputField = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLabel.right + 5, self.titleLabel.top, viewWidth() - self.titleLabel.right - 40, 15)];
            [self addSubview:_inputField];
            _inputField.delegate = self;
            
        } else if (ItemTypePicker == type) {
            
            self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.detailButton.frame = CGRectMake(self.titleLabel.right + 5, self.titleLabel.top, viewWidth() - self.titleLabel.right - 40, 15);
            [self.detailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self addSubview:self.detailButton];
            
        } else if (ItemTypeMultiChoice == type) {
            
            // 一堆button
        }
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _inputField.placeholder = placeHolder;
}

@end
