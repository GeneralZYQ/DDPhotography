//
//  IDTableViewCell.h
//  IndustrializaionPhoneApp
//
//  Created by zhangyuanqing on 16/9/15.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDObject.h"
#import "UIView+sunny.h"
#import <UIImageView+WebCache.h>
#import "Utility.h"
#import "IDInlines.h"
#import "NSDate+sunny.h"

@interface IDTableViewCell : UITableViewCell

- (void)updateCellWithObject:(IDObject *)object;

@end
