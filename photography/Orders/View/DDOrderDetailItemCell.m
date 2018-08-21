//
//  DDOrderDetailItemCell.m
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrderDetailItemCell.h"
#import "UIView+sunny.h"
#import "IDInlines.h"

@implementation DDOrderDetailItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 15)];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right, 15, viewWidth() - self.titleLabel.right - 50, 15)];
        self.detailLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.detailLabel];
        self.detailLabel.font = [UIFont systemFontOfSize:13];
        
        self.detailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth() - 55, 2, 40, 40)];
        self.detailIcon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.detailIcon];
    }
    return self;
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
