//
//  FilterCustomersConditionsView.m
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "FilterCustomersConditionsView.h"

@implementation FilterCustomersConditionsView

- (void)awakeFromNib {
    
    [super awakeFromNib];

    self.weddingButton.tag = 1;
    self.publicButton.tag = 2;
    self.activityButton.tag = 3;
    
    self.bestButton.tag = 4;
    self.goodButton.tag = 5;
    self.badButton.tag = 6;
    
    for (int i = 1; i <= 6; i++) {
        UIButton *button = [self viewWithTag:i];
        [button addTarget:self action:@selector(conditionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)conditionButtonPressed:(UIButton *)button {
    button.selected = !button.selected;
}

-(IBAction)cancelButtonPresed:(id)sender {
    for (int i = 1; i <= 6; i++) {
        UIButton *button = [self viewWithTag:i];
        button.selected = NO;
    }
}

- (IBAction)confirmButtonPressed:(id)sender {
    
    NSMutableArray *types = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *ratings = [NSMutableArray arrayWithCapacity:0];
    for (int i = 1; i <= 3; i++) {
        UIButton *button = [self viewWithTag:i];
        if (button.selected) {
            [types addObject:button.titleLabel.text];
        }
    }
    
    for (int i = 4; i <= 6; i++) {
        UIButton *button = [self viewWithTag:i];
        if (button.selected) {
            [ratings addObject:button.titleLabel.text];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(conditionsViewDidSelectConditionsTypes:ratings:)]) {
        [self.delegate conditionsViewDidSelectConditionsTypes:types ratings:ratings];
    }
}

- (IBAction)dismissButtonPressed:(id)sender {
    [self removeFromSuperview];
}

- (void)showInWindow {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

@end
