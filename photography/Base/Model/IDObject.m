//
//  HWObject.m
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/16.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDObject.h"
#import <UIKit/UIKit.h>

@implementation IDObject

- (id)initWithAttributes:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        
        self.safeDict = [NSMutableDictionary dictionaryWithCapacity:0];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([dict[key] isKindOfClass:[NSNull class]]) {
//                return self;
                [self.safeDict setObject:@"" forKey:key];
            } else {
                [self.safeDict setObject:obj forKey:key];
            }
        }];
    }
    
    return self;
}

- (float)height {
    return 44;
}

- (Class)cellClass {
    return [UITableViewCell class];
}

@end
