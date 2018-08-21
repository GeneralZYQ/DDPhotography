//
//  DDDatePicker.h
//  photography
//
//  Created by 张元清 on 2018/8/19.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^doneBlock)(NSDate *date);

@interface DDDatePicker : UIView

- (id)initWithFrame:(CGRect)frame doneBlock:(doneBlock)eblock type:(UIDatePickerMode)type;

@end
