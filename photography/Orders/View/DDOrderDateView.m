//
//  DDOrderDateView.m
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrderDateView.h"
#import "IDInlines.h"


@implementation DDOrderDateView {
    UILabel *_dateLabel;
    UILabel *_countLabel;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.messageButton.frame = CGRectMake(self.width - 48, 7, 40, 40);
        [self addSubview:self.messageButton];
        [self.messageButton addTarget:self action:@selector(messageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 300, 25)];
        _dateLabel.font = [UIFont systemFontOfSize:23];
        _dateLabel.textColor = [UIColor whiteColor];
        [self addSubview:_dateLabel];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dateLabel.right, _dateLabel.bottom - 15, 100, 15)];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.textColor = [UIColor whiteColor];
        [self addSubview:_countLabel];
    }
    return self;
}

- (void)messageButtonPressed {
    
    if ([self.delegate respondsToSelector:@selector(orderDateViewMessageButtonPressed)]) {
        [self.delegate orderDateViewMessageButtonPressed];
    }
}

- (void)reloadWithMonthCount:(NSInteger)count {
    
    NSDateFormatter *datematte = [[NSDateFormatter alloc] init];
    datematte.dateFormat = @"yyyy年MM月dd日";
    _dateLabel.text = [datematte stringFromDate:[NSDate date]];
    [_dateLabel sizeToFit];
    _countLabel.text = [NSString stringWithFormat:@"(本月共%@单)", @(count)];
    _countLabel.left = _dateLabel.right;
}

@end
