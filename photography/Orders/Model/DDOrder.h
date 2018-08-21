//
//  DDOrder.h
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "IDModel.h"

typedef enum : NSUInteger {
    OrderStatusToConfirm = 1, // 待确认
    OrderStatusTodo, // 待执行
    OrderStatusDoing, // 执行中
    OrderStatusDone, //已完成
    OrderStatusRejected, // 已拒绝
} OrderStatus;

@interface DDOrder : IDModel

//self.titles = @[@"日期", @"时段", @"到达时间", @"项目类型", @"地点", @"项目名称", @"服务类型", @"客户", @"费用", @"电话", @"备注"];

@property (nonatomic, assign) NSInteger dateStamp;
@property (nonatomic, copy) NSString *period;
@property (nonatomic, copy) NSString *arrivalTime;
@property (nonatomic, copy) NSString *projectType;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *serviceType;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, assign) float fee;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *script;
@property (nonatomic, assign) OrderStatus status;

@property (nonatomic, assign) BOOL isNew; //是否是一个新订单通知

- (NSDate *)date;
- (NSString *)statusName;

@end
