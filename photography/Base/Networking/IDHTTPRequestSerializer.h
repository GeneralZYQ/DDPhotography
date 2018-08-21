//
//  XSHTTPRequestSerializer.h
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <AFURLRequestSerialization.h>
//#import "AFURLRequestSerialization.h"


/**
 *  在这个类种，适配每一个不通的app应当写入的请求规则。
 */

@interface IDHTTPRequestSerializer : AFHTTPRequestSerializer

- (NSString *)stringByAddingQueryDictionary:(NSDictionary*)query;

@end
