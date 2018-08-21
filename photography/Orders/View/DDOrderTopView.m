//
//  DDOrderTopView.m
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrderTopView.h"
#import "IDInlines.h"
#import "UIView+sunny.h"

@implementation DDOrderTopView {
    UIButton *_searchButton;
    UIButton *_todoOrdersButton;
    UIButton *_doneOrdersButton;
    UIButton *_addButton;
    UILabel *_todoLabel;
    UILabel *_doneLabel;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(8, 8, 45, 45);
        [self addSubview:_searchButton];
        [_searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(self.width - 53, 8, 45, 45);
        [self addSubview:_addButton];
        [_addButton addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside]
        ;
        UIView *segBack = [[UIView alloc] initWithFrame:CGRectMake(_searchButton.right + 8, 8, self.width - 32 - _searchButton.width * 2, 45)];
        segBack.layer.borderWidth = 0.5;
        segBack.layer.borderColor = [[UIColor blueColor] CGColor];
        segBack.layer.cornerRadius = 45.0 / 2;
        segBack.layer.masksToBounds = YES;
        segBack.backgroundColor = [UIColor whiteColor];
        [self addSubview:segBack];
        
        _todoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, segBack.width / 2 + 10, segBack.height)];
        _todoLabel.text = @"待办订单";
        _todoLabel.textAlignment = NSTextAlignmentCenter;
        _todoLabel.layer.cornerRadius = segBack.height / 2;
        _todoLabel.clipsToBounds = YES;
        _todoLabel.backgroundColor = [UIColor blueColor];
        _todoLabel.textColor = [UIColor whiteColor];
        [segBack addSubview:_todoLabel];
        
        _doneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_todoLabel.right - 5, 0, _todoLabel.width, segBack.height)];
        _doneLabel.text = @"已办订单";
        _doneLabel.textAlignment = NSTextAlignmentCenter;
        _doneLabel.layer.cornerRadius = segBack.height / 2;
        _doneLabel.clipsToBounds = YES;
        _doneLabel.backgroundColor = [UIColor whiteColor];
        _doneLabel.textColor = [UIColor blueColor];
        [segBack addSubview:_doneLabel];
        
        [segBack bringSubviewToFront:_todoLabel];
        
        _todoOrdersButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _todoOrdersButton.frame = CGRectMake(0, 0, segBack.width / 2, segBack.height);
        [segBack addSubview:_todoOrdersButton];
        [_todoOrdersButton addTarget:self action:@selector(todoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        _doneOrdersButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneOrdersButton.frame = CGRectMake(_todoOrdersButton.right, 0, _todoOrdersButton.width, _todoOrdersButton.height);
        [segBack addSubview:_doneOrdersButton];
        [_doneOrdersButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)searchButtonPressed {
    if ([self.delegate respondsToSelector:@selector(orderTopViewSearchButtonPressed)]) {
        [self.delegate orderTopViewSearchButtonPressed];
    }
}

- (void)addButtonPressed {
    if ([self.delegate respondsToSelector:@selector(orderTopViewAddButtonPressed)]) {
        [self.delegate orderTopViewAddButtonPressed];
    }
}

- (void)todoButtonPressed {
    
    [_todoLabel.superview bringSubviewToFront:_todoLabel];
    _todoLabel.backgroundColor = [UIColor blueColor];
    _todoLabel.textColor = [UIColor whiteColor];
    _doneLabel.backgroundColor = [UIColor whiteColor];
    _doneLabel.textColor = [UIColor blueColor];
    if ([self.delegate respondsToSelector:@selector(orderTopViewTodoButtonPressed)]) {
        [self.delegate orderTopViewTodoButtonPressed];
    }
}

- (void)doneButtonPressed {
    [_doneLabel.superview bringSubviewToFront:_doneLabel];
    _doneLabel.backgroundColor = [UIColor blueColor];
    _doneLabel.textColor = [UIColor whiteColor];
    _todoLabel.backgroundColor = [UIColor whiteColor];
    _todoLabel.textColor = [UIColor blueColor];
    if ([self.delegate respondsToSelector:@selector(orderTopViewDoneButtonPressed)]) {
        [self.delegate orderTopViewDoneButtonPressed];
    }
}

@end
