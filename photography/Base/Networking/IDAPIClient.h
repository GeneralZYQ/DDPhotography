//
//  HWAPIClient.h
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/11.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface IDAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

+ (instancetype)downloadClient;

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *) request
                                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters;

- (NSURLSessionDownloadTask *) downLoadFilePath: (NSString*)path
                                      localPath: (NSString*)localPath
                                     parameters: (NSDictionary*)para
                                        success: (void (^)(NSURLSessionDownloadTask *task, id responseObject))success
                                        failure: (void (^)(NSURLSessionDownloadTask *task, NSError *error))failure
                                       progress: (void (^)(NSProgress *currentProgress)) progressBlock;

- (NSURLSessionDownloadTask *) downLoadFilePath: (NSString*)path
                                      localPath: (NSString*)localPath
                                        success: (void (^)(NSURLSessionDownloadTask *task, id responseObject))success
                                        failure: (void (^)(NSURLSessionDownloadTask *task, NSError *error))failure
                                       progress: (void (^)(NSProgress *currentProgress)) progressBlock;

- (void)cancel;

@end
