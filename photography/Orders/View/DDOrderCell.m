//
//  DDOrderCell.m
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrderCell.h"
#import "UIView+sunny.h"
#import "IDInlines.h"

@implementation DDOrderCell {
    UILabel *_dateLabel;
    UILabel *_nameLabel;
    UILabel *_statusLabel;
    UIView *_rejLine;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 40, 14)];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dateLabel];
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth() - 40, 17, 30, 10)];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.backgroundColor = [UIColor redColor];
        _statusLabel.font = [UIFont systemFontOfSize:9];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_statusLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dateLabel.right + 15, 15, _statusLabel.left - _dateLabel.right - 30, 14)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_nameLabel];
        
        _rejLine = [[UIView alloc] initWithFrame:CGRectMake(5, 22, viewWidth() - 10, 0.5)];
        _rejLine.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_rejLine];
    }
    return self;
}

- (void)setOrder:(DDOrder *)order {
    _order = order;
    NSDateFormatter *datematte = [[NSDateFormatter alloc] init];
    datematte.dateFormat = @"dd日";
    _dateLabel.text = [datematte stringFromDate:[_order date]];
    
    _nameLabel.text = order.name;
    _statusLabel.text = [order statusName];
    
    if (order.status == OrderStatusToConfirm) {
        _statusLabel.backgroundColor = [UIColor redColor];
    } else if (order.status == OrderStatusTodo) {
        _statusLabel.backgroundColor = [UIColor greenColor];
    } else if (order.status == OrderStatusDoing) {
        _statusLabel.backgroundColor = [UIColor yellowColor];
    } else if (order.status == OrderStatusDone) {
        _statusLabel.backgroundColor = [UIColor blueColor];
    } else if (order.status == OrderStatusRejected) {
        _statusLabel.backgroundColor = [UIColor blackColor];
    }
    
    _rejLine.hidden = order.status != OrderStatusRejected;
}

@end
