//
//  DDDateOrderCell.m
//  photography
//
//  Created by 张元清 on 2018/8/21.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDDateOrderCell.h"
#import "DDOrder.h"

@implementation DDDateOrderCell {
    UILabel *_proTypeLabel;
    UILabel *_timeLabel;
    UILabel *_nameLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _proTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 11, 22, 22)];
        _proTypeLabel.textAlignment = NSTextAlignmentCenter;
        _proTypeLabel.textColor = [UIColor whiteColor];
        _proTypeLabel.layer.cornerRadius = 11;
        _proTypeLabel.clipsToBounds = YES;
        [self.contentView addSubview:_proTypeLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_proTypeLabel.right + 40, 12, 40, 20)];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_proTypeLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.right + 40, 12, viewWidth() - _timeLabel.right - 40, 20)];
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

- (void)updateCellWithObject:(IDObject *)object {
    if ([object isKindOfClass:[DDOrder class]]) {
        DDOrder *order = (DDOrder *)object;
        
        if ([order.projectType isEqualToString:@"婚礼"]) {
            _proTypeLabel.text = @"婚";
        } else if ([order.projectType isEqualToString:@"宣传片"]) {
            _proTypeLabel.text = @"宣";
        } else if ([order.projectType isEqualToString:@"活动会议"]) {
            _proTypeLabel.text = @"会";
        } else if ([order.projectType isEqualToString:@"其他"]) {
            _proTypeLabel.text = @"其";
        }
        
        _timeLabel.text = order.arrivalTime;
        _nameLabel.text = order.name;
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
