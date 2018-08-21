//
//  DDOrder.m
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "DDOrder.h"

@implementation DDOrder

- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.dateStamp];
}

- (NSString *)statusName {

    if (self.status == OrderStatusToConfirm) {
        return @"待确认";
    } else if (self.status == OrderStatusTodo) {
        return @"待执行";
    } else if (self.status == OrderStatusDoing) {
        return @"执行中";
    } else if (self.status == OrderStatusDone) {
        return @"已完成";
    } else if (self.status == OrderStatusRejected) {
        return @"已拒绝";
    }
    return @"";
}

@end
