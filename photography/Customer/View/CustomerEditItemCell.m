//
//  CustomerEditItemCell.m
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "CustomerEditItemCell.h"

@implementation CustomerEditItemCell

- (void)setEditingItem:(CustomerEditItemObject *)editingItem {
    _editingItem = editingItem;
    if (editingItem.editType == EditTypePicker) {
        self.valueField.enabled = NO;
    } else {
        self.valueField.enabled = YES;
    }
    
    self.titleLabel.text = editingItem.title;
    self.valueField.text = editingItem.currentValue;
    [self.iconButton setImage:[UIImage imageNamed:editingItem.icon] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.editingItem.currentValue = self.valueField.text;
    return YES;
}

@end
