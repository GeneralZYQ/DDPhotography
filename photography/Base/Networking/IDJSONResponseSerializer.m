//
//  HWJSONResponseSerializer.m
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/11.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDJSONResponseSerializer.h"
#import "IDInlines.h"

@implementation IDJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    id JSON = [super responseObjectForResponse:response data:data error:error];
    
     NSLog(@"the res is %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //{"isOk":false,"desc":"\u7f3a\u5c11method\u53c2\u6570","data":[]}<br />
    //<b>Notice</b>
    if ([JSON isKindOfClass: [NSDictionary class]]) {
        
        if ([JSON[@"status"] integerValue] < 0) {
            NSString *errorMsg = JSON[@"error_message"];
            NSDictionary* userInfo = @{@"error_msg" : SODescriptionForResponceObject(JSON), @"responseObject" : JSON};
            
            *error = [[NSError alloc] initWithDomain: NSURLErrorDomain
                                                code: [JSON[@"status"] integerValue]
                                            userInfo: userInfo];
        }
//        
//        if (!!JSON[@"code"]) {
//            if ([JSON[@"code"] integerValue] >= 100) {
//                NSString *errorMsg = @"";
//                if ([JSON isKindOfClass: [NSDictionary class]]) {
//                    
//                    errorMsg = JSON[@"remindMsg"];
//                } else {
//                    errorMsg = @"未知错误";
//                }
//                
//                NSDictionary* userInfo = @{@"error_msg" : SODescriptionForResponceObject(JSON), @"responseObject" : JSON};
//                
//                *error = [[NSError alloc] initWithDomain: NSURLErrorDomain
//                                                    code: [JSON[@"code"] integerValue] == 212?kNeedLoginCode:[JSON[@"code"] integerValue]
//                                                userInfo: userInfo];
//            }
//        }
    }
    
    return JSON;
}

@end
