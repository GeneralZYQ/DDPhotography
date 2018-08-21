//
//  DDCreateOrderItemView.h
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ItemTypeDate = 1,
    ItemTypePicker,
    ItemTypeInput,
    ItemTypeMultiChoice,
} ItemType;

@interface DDCreateOrderItemView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIImageView *nessaceryTag;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, copy) NSString *placeHolder;

- (id)initWithType:(ItemType)type icon:(NSString *)icon frame:(CGRect)frame;

@end
