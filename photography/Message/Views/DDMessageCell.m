//
//  DDMessageCell.m
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDMessageCell.h"

@implementation DDMessageCell {
    UILabel *_nameLabel;
    UILabel *_contentLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 100, 17)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + 15, viewWidth() - 100, 50)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)updateCellWithObject:(IDObject *)object {
    if ([object isKindOfClass:[DDMessage class]]) {
        DDMessage *message = (DDMessage *)object;
        _nameLabel.text = message.title;
        _contentLabel.text = message.content;
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
