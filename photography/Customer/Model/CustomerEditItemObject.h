//
//  CustomerEditItemObject.h
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EditType) {
    EditTypeInput = 1, // 输入的
    EditTypePicker, // 选择的
};

@interface CustomerEditItemObject : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *currentValue;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) EditType editType;
@property (nonatomic, assign) BOOL isNull;

@end
