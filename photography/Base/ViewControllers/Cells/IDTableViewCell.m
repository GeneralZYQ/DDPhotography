//
//  IDTableViewCell.m
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 16/9/15.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDTableViewCell.h"

@implementation IDTableViewCell {
    
    IDObject *_item;
}

- (void)updateCellWithObject:(IDObject *)object {
    
    _item = object;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
