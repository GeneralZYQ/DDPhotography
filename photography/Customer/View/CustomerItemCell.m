//
//  CustomerItemCell.m
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "CustomerItemCell.h"

@implementation CustomerItemCell

- (void)setItem:(CustomerItemObject *)item {
    _item = item;
    self.titleLabel.text = item.title;
    self.itemLabel.text = item.item;
    if (item.isLeft) {
        self.itemLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        self.itemLabel.textAlignment = NSTextAlignmentRight;
    }
    if (item.icon.length) {
        self.icon.hidden = NO;
    } else {
        self.icon.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
