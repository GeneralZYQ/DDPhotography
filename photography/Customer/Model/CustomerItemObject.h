//
//  CustomerItemObject.h
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerItemObject : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) BOOL isLeft; // 是否详情靠左显示
@property (nonatomic, assign) BOOL isNull; // 是否只是一个分隔符

@end
