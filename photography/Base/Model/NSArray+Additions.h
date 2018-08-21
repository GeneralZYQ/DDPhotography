//
//  NSArray+Additions.h
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(Additions)

- (void)perform:(SEL)selector;
- (void)perform:(SEL)selector withObject:(id)p1;
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2;

@end
