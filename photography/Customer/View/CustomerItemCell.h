//
//  CustomerItemCell.h
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerItemObject.h"

@interface CustomerItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *itemLabel;
@property (nonatomic, weak) IBOutlet UIImageView *icon;

@property (nonatomic, strong) CustomerItemObject *item;

@end
