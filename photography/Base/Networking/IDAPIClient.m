//
//  HWAPIClient.m
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/11.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDAPIClient.h"
#import "IDHTTPRequestSerializer.h"
#import "IDJSONResponseSerializer.h"
#import "IDConfig.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation IDAPIClient

+ (instancetype)sharedClient {
    static IDAPIClient *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[IDAPIClient alloc] initWithBaseURL:[NSURL URLWithString: API_HOST]];
    });
    
    return sharedClient;
}

+ (instancetype)downloadClient {
    static IDAPIClient *downloadClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadClient = [[IDAPIClient alloc] initWithBaseURL:[NSURL URLWithString: API_HOST]];
        //        downloadClient.operationQueue.maxConcurrentOperationCount = 2;
    });
    
    return downloadClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
        // 为了https请求正常
        self.securityPolicy.allowInvalidCertificates = YES;
        
        self.requestSerializer = [IDHTTPRequestSerializer serializer];
        [self.requestSerializer setValue: @"application/json"
                      forHTTPHeaderField: @"Accept"];
        
        self.responseSerializer = [IDJSONResponseSerializer serializer];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    
    
    return self;
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *) request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                      success:(void (^)(NSURLSessionDataTask *, id))success
                                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:^(NSProgress * _Nonnull uploadProgressBlock) {
                              if (uploadProgress) {
//                                  dispatch_main_async_safe(^{
//
//                                  });
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      uploadProgress(uploadProgressBlock);
                                  });
                              }
                              
                          } downloadProgress:^(NSProgress * _Nonnull downloadProgressBlock) {
                              if (downloadProgress) {
//                                  dispatch_main_async_safe(^{
//                                      downloadProgress(downloadProgressBlock);
//                                  });
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      downloadProgress(downloadProgressBlock);
                                  });
                              }
                          } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                              if (error) {
                                  if (failure) {
                                      failure(dataTask, error);
                                      if (error.code == kNeedLoginCode) {
                                          //#if defined(IN_FIVEONETALK) || defined(IN_SPEAKOUT)
//                                          [[AutoLoginManager sharedInstance] doAutoLogin];
                                          //#else
                                          //                                       NIDASSERT(NO);
                                          //#endif
                                      }
                                      
                                  }
                              } else {
                                  if (success) {
                                      success(dataTask, responseObject);
                                  }
                              }
                          }];
    
    return dataTask;
    
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *) request
                                      success:(void (^)(NSURLSessionDataTask *, id))success
                                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    return [self dataTaskWithRequest: request
                      uploadProgress: nil
                    downloadProgress: nil
                             success: success
                             failure: failure];
    
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }
    
    
    
    
    return [self dataTaskWithRequest: request
                      uploadProgress: uploadProgress
                    downloadProgress: downloadProgress
                             success: success
                             failure: failure];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
    // 加入域名
    NSURL *resultUrl = [NSURL URLWithString:path relativeToURL:self.baseURL];
    path = [resultUrl absoluteString];
    NSError *error;
    return [self.requestSerializer requestWithMethod: method
                                           URLString: path
                                          parameters: parameters
                                               error: &error];
    
}

- (NSURLSessionDownloadTask *) downLoadFilePath: (NSString*)path
                                      localPath: (NSString*)localPath
                                     parameters: (NSDictionary*)para
                                        success: (void (^)(NSURLSessionDownloadTask *task, id responseObject))success
                                        failure: (void (^)(NSURLSessionDownloadTask *task, NSError *error))failure
                                       progress: (void (^)(NSProgress *currentProgress)) progressBlock{
    
    
    NSMutableURLRequest *originRequest = [self.requestSerializer requestWithMethod: @"GET"
                                                                         URLString: path
                                                                        parameters: para
                                                                             error: nil];
    originRequest.timeoutInterval = 60;
    
    NSURLSessionDownloadTask *downloadTask = [self downloadTaskWithRequest:originRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
//            dispatch_main_async_safe(^{
//                progressBlock(downloadProgress);
//            });
            dispatch_async(dispatch_get_main_queue(), ^{
                progressBlock(downloadProgress);
            });
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:localPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(downloadTask, error);
        }else{
            success(downloadTask, response);
        }
    }];
    
    [downloadTask resume];
    
    return downloadTask;
}

- (NSURLSessionDownloadTask *) downLoadFilePath: (NSString*)path
                                      localPath: (NSString*)localPath
                                        success: (void (^)(NSURLSessionDownloadTask *task, id responseObject))success
                                        failure: (void (^)(NSURLSessionDownloadTask *task, NSError *error))failure
                                       progress: (void (^)(NSProgress *currentProgress)) progressBlock{
    return [self downLoadFilePath: path
                        localPath: localPath
                       parameters: nil
                          success: success
                          failure: failure
                         progress: progressBlock];
}

- (void)cancel {
    
    
}


@end
