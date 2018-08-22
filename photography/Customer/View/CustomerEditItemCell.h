//
//  CustomerEditItemCell.h
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerEditItemObject.h"

@interface CustomerEditItemCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextField *valueField;
@property (nonatomic, weak) IBOutlet UIButton *iconButton;

@property (nonatomic, strong) CustomerEditItemObject *editingItem;

@end
