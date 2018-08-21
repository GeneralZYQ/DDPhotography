//
//  DDCustomer.h
//  photography
//
//  Created by 张元清 on 2018/8/21.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCustomer : NSObject

@property (nonatomic, strong) NSString *customerType; //婚礼，宣传，活动
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger ordersCount; // 一共做了多少单
@property (nonatomic, assign) NSInteger rating; // 评分高低，用来显示星星
@property (nonatomic, assign) NSInteger earn; // 从这个客户身上的收入
@property (nonatomic, assign) NSInteger debit; // 这个客户欠我多少钱
@property (nonatomic, copy) NSString *contactName; //联系人的名字
@property (nonatomic, copy) NSString *phone;

@end
