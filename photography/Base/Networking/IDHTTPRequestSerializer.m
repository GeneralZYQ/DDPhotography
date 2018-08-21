//
//  XSHTTPRequestSerializer.m
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDHTTPRequestSerializer.h"
#import "NSString+SO.h"
#import "IDConfig.h"
#import "NSString+URLEncoding.h"
#import "IDInlines.h"
#import "Utility.h"

@implementation IDHTTPRequestSerializer

- (id)init {
    self = [super init];
    if (self) {
        // as default
        self.timeoutInterval = 15;
    }
    return self;
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [[query allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare: obj2];
    }]) {
        
//        BOOL contans = NO;
//        
//        for (NSString *paraKey in [para allKeys]) {
//            if ([paraKey isEqualToString:key]) {
//                contans = YES;
//            }
//        }
        
//        if (!contans) {
            NSString* value = [GET_STRING([query objectForKey:key]) URLEncodedString];
            NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
            [pairs addObject:pair];
//        }
        
    }
    
    
    NSLog(@"the pairs are %@", pairs);
    NSString* params = [pairs componentsJoinedByString:@"&"];
    
    return params;
}

- (NSString *)stringByUsingForMD5:(NSDictionary *)query {
    
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [[query allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare: obj2];
    }]) {
        NSString* value = GET_STRING([query objectForKey:key]);
        NSString* pair = [NSString stringWithFormat:@"%@%@", key, value];
        [pairs addObject:pair];
    }
    
    
    NSLog(@"the pairs are %@", pairs);
    NSString* params = [pairs componentsJoinedByString:@""];
    
    return params;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(id)parameters error:(NSError *__autoreleasing  _Nullable *)error {
    NSString *newURLString = [URLString copy];
    NSURL *newURL = [NSURL URLWithString: newURLString];
    NSMutableDictionary *mutaDict = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!!parameters) {
        [mutaDict addEntriesFromDictionary: parameters];
    }
    
    [mutaDict setObject:kSignConstString forKey:@"appKey"];
    [mutaDict setObject:@"1.0" forKey:@"v"];
    [mutaDict setObject:@"json" forKey:@"format"];
    [mutaDict setObject:method forKey:@"method"];
    [mutaDict setObject:[NSString stringWithFormat:@"%@", @([[NSDate date] timeIntervalSince1970])] forKey:@"timestamp"];
    [mutaDict setObject:[Utility getUUID] forKey:@"userCode"];
    if (parameters[@"page"]) {
        [mutaDict setObject:parameters[@"page"] forKey:@"pageId"];
    }
    
    NSString *queryString = [self stringByAddingQueryDictionary: mutaDict];//array_merge($sysParams,$postData);
    NSString *useToSignString = [self stringByUsingForMD5:mutaDict];
    
    NSString *md5String = [[useToSignString md5Hash] uppercaseString];
    [mutaDict setObject:md5String forKey:@"sign"];
    
    newURLString = [NSString stringWithFormat:@"%@%@", API_HOST, URLString];//, [self stringByAddingQueryDictionary:mutaDict]
    
    if ([method isEqualToString:@"POST"]) {
        NSLog(@"the parameters are %@", parameters);
        NSLog(@"the newURL Sring is %@", newURLString);
        NSLog(@"the usetosting is %@", useToSignString);;
        
        return [super requestWithMethod: @"POST"
                              URLString: newURLString
                             parameters: [parameters copy]
                                  error: error];
    } else {
        return [super requestWithMethod: @"GET"
                              URLString: newURLString
                             parameters: [parameters copy]
                                  error: error];
    }
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(NSDictionary *)parameters
                              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError *__autoreleasing *)error {
    
    
    NSString *newURLString = [URLString urlPathWithCommonStat];
    NSURL *newURL = [NSURL URLWithString: newURLString];
    NSDictionary *getQuery = [newURL.query queryDictionaryUsingEncoding: NSUTF8StringEncoding];
    NSMutableDictionary *mutaDict = [NSMutableDictionary dictionaryWithDictionary: getQuery];
    if (!!parameters) {
        [mutaDict addEntriesFromDictionary: parameters];
    }
    
    NSLog(@"the mutaDict is %@", mutaDict);
    
    NSString *queryString = [self stringByAddingQueryDictionary: mutaDict];
    NSString *signString = [queryString stringByAppendingString: kSignConstString];
    NSString *sign = [signString md5Hash];
    
    NSMutableDictionary *queryWithSign = [NSMutableDictionary dictionaryWithDictionary: parameters];
    queryWithSign[@"paramSign"] = [XSInlines ensureNotNull:sign];
    return [super multipartFormRequestWithMethod: method
                                       URLString: URLString
                                      parameters: parameters
                       constructingBodyWithBlock: block
                                           error: error];
}



@end
