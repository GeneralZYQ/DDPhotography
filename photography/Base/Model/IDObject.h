//
//  HWObject.h
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/16.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
//#import "NSDictionary+safe.h"

@interface IDObject : NSObject

@property (nonatomic, strong) NSMutableDictionary *safeDict;

- (id)initWithAttributes:(NSDictionary *)dict;
- (float)height;

- (Class)cellClass;

@end
