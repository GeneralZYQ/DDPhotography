//
//  HWURLRequestModel.m
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/11.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDURLRequestModel.h"
#import "IDAPIClient.h"
#import "IDInlines.h"
#import "NSDataAdditions.h"
#import "NSString+URLEncoding.h"
#import "Utility.h"
#import "IDConfig.h"
//#include "MBProgressHUD.h"
#import "IDObject.h"

@implementation IDURLRequestModel {
    
}


- (id) initWithBaseURL: (NSString*) path
         andHttpClient: (IDAPIClient*) client
          andHttpParse: (ID_HTTP_PARSE_BLOCK) parseBlock
            parameters: (NSDictionary *)parameters{
    
    self = [super init];
    if (self) {
        _path = path;
        _httpClient = client;
        _parameters = parameters;
        _customHttpObjectParser = parseBlock;
        
        
    }
    
    return self;
}

- (id) initWithBaseURL: (NSString*) path
         andHttpClient: (IDAPIClient*) client
               isPaged: (BOOL) isPaged
             withClass: (Class)className
          andHttpParse: (id<IDModelDelegate>) delegate
            parameters: (NSDictionary *)parameters{
    
    self = [super init];
    if (self) {
        _path = path;
        
        _httpClient = client;
        _parameters = parameters;
        
        _startNum = 0;
        _stepCount = 20;
        _page = 1;
        _startPage = 1;
        _isPaged = isPaged;
        _customString = @"";
        
        //  httpMethod默认为GET,初始化后用户可以自己设置httpMethod
        _httpMethod = path;
        _isTimeSensitive = NO;
        
        
        if (!_isPaged) {
            _stepCount = 10000;
        }
        
        _sections = [NSMutableArray arrayWithCapacity:0];
        
        _paramNameStartNum = @"start_num";
        _paramNameStepCount = @"pageSize";
        _paramNamePage = @"pageId";
        _paramNameCustomString = @"customString";
        
        [self.delegates addObject:delegate];
        
        
        _timestamp = (int)[[NSDate date] timeIntervalSince1970];
        _hasMoreByNonZero = NO;
        
        _loadFromFile = YES;     // 默认不从文件加载内容
        _requestCount = 0;
        
        _className = className;
    }
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [_sessionTask cancel];
    _sessionTask = nil;
    
}

- (void)load:(SNURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!_path) {
        return;
    }
    
    if (more) {
        if (!_hasMore) {
            [self requestDidFinishLoad: nil withObject: [NSArray array] continueLoad: NO];
            return;
        }
    }
    
    // 通过时间戳来控制是否强制刷新
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if (_isTimeSensitive) {
        parameters[@"_t"] = @(_timestamp);
    }
    
    // 增加用户的额外参数
    if (_parameters) {
        [parameters addEntriesFromDictionary: _parameters];
    }
    
    // 如果Model被修改了，则强制从第一页开始加载
    if (self.modelChanged) {
        more = NO;
        self.modelChanged = NO;
    }
    
    _isLoadingMore = NO;
    _isLoading = YES;
    if (_isPaged) {
        
        if (!more) {
            _startNum = 0;
            _page = _startPage;
            _customString = @"";
            [_sections removeAllObjects];
        } else {
            _isLoadingMore = YES;
        }
//        parameters[_paramNameStartNum] = @(_startNum);
//        parameters[_paramNameStepCount] = @(_stepCount);
        parameters[_paramNamePage] = @(_page);
        parameters[_paramNameCustomString] = [XSInlines ensureNotNull:_customString];
    }
    
    NSLog(@"the parames are %@", parameters);
    NSMutableURLRequest *request = [_httpClient requestWithMethod: _httpMethod
                                                             path: _path
                                                       parameters: parameters];
    
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    NIDPRINT(@"HttpURl: %@", request.URL);
    NSLog(@"HttpURl: %@", request.URL);
    
    // 现存缓存加载
    if (_loadFromFile && _isLoading  && !more && !_customHttpObjectParser) {
        
        //        [self didStartLoad];
        
        NSString* fileName = [request.URL.absoluteString md5Hash];
        NSString* dirName = [Utility getTmpFilePath: @"cached_json_file/"];
        NSString *filePath = [Utility getTmpFilePath: [NSString stringWithFormat: @"cached_json_file/%@.cache", fileName]];//
        
        
        // 需要从文件预加载的内容，直接先从文件加载
        
        BOOL isDir = YES;
        if (![[NSFileManager defaultManager] fileExistsAtPath: dirName
                                                  isDirectory: &(isDir)]) {
            
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath: dirName
                                      withIntermediateDirectories: NO
                                                       attributes: nil
                                                            error: &error];
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
            id cachedJSON = [NSDictionary dictionaryWithContentsOfFile: filePath];
            
            if (!cachedJSON) {
                cachedJSON = [NSArray arrayWithContentsOfFile: filePath];
            }
            if (!!cachedJSON) {
                if (!more) {
                    // 清空现有的数据:
                    [_sections removeAllObjects];
                }
                
                // 解析数据
            if (_className) {
                // 默认的解析:
                // 假定我们的数据都是JSON
                NSMutableArray* items = [NSMutableArray array];
                NSArray* jsonArray = cachedJSON;
                
                for (int i = 0; i < jsonArray.count; i++) {
                    
                    IDObject *item = [[_className alloc] initWithAttributes:jsonArray[i]];
                    [items addObject: item];
                    
                }
                [_sections addObjectsFromArray: items];
//                for (int i = 0; i < jsonArray.count; i++) {
////                    SNTableItem* item = _tableItemFactory(jsonArray[i]);
//                    
//                    // 此时进行数据虑重，已经出现的数据不再添加进来
//                    if ([_filterKey isNonEmpty]) {
//                        if (!_filterSet) {
//                            _filterSet = [NSMutableSet set];
//                        }
//                        
//                        id filterValue = jsonArray[i][_filterKey];
//                        if (filterValue && ![_filterSet containsObject: filterValue]) {
//                            
//                            // 列表中已经包含数据了，不再添加
//                            continue;
//                        } else {
//                            
//                            [_filterSet addObject: filterValue];
//                        }
//                    }
//                    
//                    [items addObject: item];
//                    
//                }
//                [_section.rows addObjectsFromArray: items];
                
                // cache读取的数据默认无法加载更多，只能通过更新数据后才能家在更多
                _hasMore = NO;
            }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self requestDidFinishLoad: nil withObject: cachedJSON continueLoad: YES];
                });
            }
        }
    }
    
    // 取消旧的Request
    
    
    //    _sessionTask.completionBlock = nil;
    [_sessionTask cancel];
    _sessionTask = nil;
    
    _isLoading = YES;
    
    // 我们假定请求是JSON格式的
    __weak typeof(self) _self = self;
    
    __block NSURLSessionDataTask *task = nil;
    
    task = [_httpClient dataTaskWithRequest:request success:^(NSURLSessionDataTask *task, id responseObject) {
        // 解析结果:破
        // 放在什么地方来解析呢?
        // 有自定义的代码可以解析
        // 支持基于block的解析
        //        NIDPRINT(@"====> URL Request Finished, Status code: %ld <====", ((NSHTTPURLResponse *)task.response).statusCode);
        
        if (_customHttpObjectParser) {
            _customHttpObjectParser(responseObject, self);
            return ;
        }
        
        
        if (!more) {
            // 清空现有的数据:
            [_sections removeAllObjects];
        }
         [_sections removeAllObjects];
        
        // 解析数据
            // 默认的解析:
            // 假定我们的数据都是JSON
        NSMutableArray* items = [NSMutableArray array];
        NSArray* jsonArray = responseObject[@"data"][parameters[@"method"]][@"data"];
        NSDictionary *pageDict = responseObject[@"data"][parameters[@"method"]][@"page"];
        NSLog(@"the jsonArray is %@", jsonArray);
        for (int i = 0; i < jsonArray.count; i++) {
            
            IDObject *item = [[_className alloc] initWithAttributes:jsonArray[i]];
            [items addObject: item];
            
        }
        [_sections addObjectsFromArray: items];
        
        _startNum += _stepCount;
        _page ++;
        
        if (_isPaged) {
//            if (_hasMoreByNonZero) {
//                _hasMore = items.count > 0;
//            } else {
//                _hasMore = items.count >= _stepCount;
//            }
            _hasMore = [pageDict[@"isHasNext"] boolValue];
        }
        
        
        [self requestDidFinishLoad: task withObject: _sections continueLoad: NO];
        
        // 展示玩数据再保存，防止保存错误的数据
        if (!more) {
            // 首先替换NSNull
            if (_loadFromFile) {
                NSString* fileName = [request.URL.absoluteString md5Hash];
                NSString *filePath = [Utility getTmpFilePath: [NSString stringWithFormat: @"cached_json_file/%@.cache", fileName]];
                
                id writeToFileData = [[_self class] getFilteredData: responseObject];
                NSLog(@"the writeToFileData %@", writeToFileData);
                NSLog(@"file path is %@", filePath);
                
                if ([writeToFileData isKindOfClass: [NSDictionary class]] && [filePath isNonEmpty]) {
                    NSDictionary* dict = writeToFileData;
                    [dict writeToFile: filePath
                           atomically: YES];
                }else if ([writeToFileData isKindOfClass: [NSArray class]] && [filePath isNonEmpty]) {
                    NSArray* array = writeToFileData;
                    [array writeToFile: filePath
                            atomically: YES];
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (_loadFromFile && !more) {
            //            [_self request: operation didFailLoadWithError: error];
            
            if (_requestCount < 3) {
                // 如果增量更新切失败次数《3
                [_self load: cachePolicy more: more];
            } else {
                [_self request: task didFailLoadWithError: error];
            }
            
            _requestCount ++;
        } else {
            
            [_self request: task didFailLoadWithError: error];
            
        }
        
        //        NSString* requestUrl = [operation.request.URL absoluteString];
        //        NSUserDefaults* info = [NSUserDefaults standardUserDefaults];
        //        NSString* requestUrl = [info objectForKey: kLastLogInHost];
        
        // 如果碰到302请求
        if ([error.userInfo[@"status_code"] intValue] == 302) {
            [[NSNotificationCenter defaultCenter] postNotificationName: kSNLoginExpired object: nil];
        }
        
        //            [MobClick event: @"request_code_from_error" label: GET_STRING(@(error.code))];
        //            [MobClick event: @"request_code_from_operation" label: GET_STRING(@(operation.response.statusCode))];
//#ifdef DEBUG
//        
//        [MBProgressHUD showErrorWithStatus: [NSString stringWithFormat: @"错误code %@ statusCode:%@", @(error.code), @(((NSHTTPURLResponse *)task.response).statusCode)]];
//#endif
        
    }];
    
    //    if ([request.URL.absoluteString hasPrefix:@"https://"]) {
    //        operation.allowHttpsAccess = YES;
    //        operation.shouldUseCredentialStorage = NO;
    //    }
    
    _sessionTask = task;
    
    // 注意是订阅谁的消息, 定向发送Notification
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(taskDidStart:)
                                                 name: AFNetworkingTaskDidResumeNotification
                                               object: _sessionTask];
    // 注意是订阅谁的消息, 定向发送Notification
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(operationDidCancel:)
                                                 name: AFNetworkingTaskDidCompleteNotification
                                               object: _sessionTask];
    
    [_sessionTask resume];
    
}

+ (id) getFilteredData:(id)JSON {
    if([JSON isKindOfClass: [NSArray class]]) {
        
        return [self filterNSNullInJSON: JSON];
    } else if ([JSON isKindOfClass: [NSDictionary class]]) {
        
        NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary: JSON];
        return [self filterNSNullInJSON: mutableDict];
    }
    return nil;
}

// 递归遍历 JSON 把 NSNull 过滤掉,因为有NSNull的话无法保存到文件
+ (id) filterNSNullInJSON:(id)json {
    if ([json isKindOfClass: [NSArray class]]) {
        
        NSMutableArray* array = [NSMutableArray array];
        for (id subJSON in json) {
            if ([subJSON isKindOfClass: [NSDictionary class]]) {
                
                NSMutableDictionary* mutableDict = [NSMutableDictionary dictionaryWithDictionary: subJSON];
                [array addObject: [self filterNSNullInJSON: mutableDict]];
                
            } else if([subJSON isKindOfClass: [NSArray class]]) {
                
                NSMutableArray* mutableArray = [NSMutableArray arrayWithArray: subJSON];
                [array addObject: [self filterNSNullInJSON: mutableArray]];
            } else {
                
                // 什么也不做
            }
        }
        return array;
        
    } else if([json isKindOfClass: [NSDictionary class]]){
        
        NSMutableDictionary* dict = json;
        for (NSString* key in [dict allKeys]) {
            if ([dict[key] isKindOfClass: [NSNull class]]) {
                
                dict[key] = @"";
            } else if ([dict[key] isKindOfClass: [NSDictionary class]]) {
                
                NSMutableDictionary* subDict = [NSMutableDictionary dictionaryWithDictionary: dict[key]];
                dict[key] = [self filterNSNullInJSON: subDict];
                
            } else if ([dict[key] isKindOfClass: [NSArray class]]) {
                
                dict[key] = [self filterNSNullInJSON: dict[key]];
            }
        }
        return dict;
    }

    return [NSNull null];
}

- (BOOL) hasMore {
    if (_isPaged) {
        return _hasMore;
    } else {
        return NO;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reset {
    // 需要重新加载数据
    //    _startNum = 0;
    //    _page = _startPage;
    //    _loadedTime = nil;
    _timestamp = (int)[[NSDate date] timeIntervalSince1970];
}

- (void)cancelAll {
    
    [self cancel];
}


- (void) taskDidStart: (NSNotification*) notification {
    NSURLSessionTask * task = notification.object;
    // Request开始
    [self requestDidStartLoad: task];
}

- (void) operationDidCancel: (NSNotification*) notification {
    NSURLSessionTask* task = notification.object;
    if (task.error) {
        NSError* error = task.error;
        if ([NSURLErrorDomain isEqualToString: error.domain] &&  error.code == NSURLErrorCancelled) {
            // Request取消
            [self requestDidCancelLoad: task];
        }
    }
}


#pragma mark - SNModel


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    return (!_path) || (!!_loadedTime);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return _isLoading;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return _isLoadingMore;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutdated {
    if (!!self.customOutDateBlock) {
        
        // 即使有custom，也会判断一下1分钟一次的刷新
        // 为什么要放30秒的间隔呢，是因为每次加载完都会走一遍检查需不需要reload，走到这个方法里面，如果服务器返回的数据有问题，或者用户把本地时间改了customOutDateBlock，永远为YES，这种情况下需要设一个最短间隔30秒
        BOOL outDated = self.customOutDateBlock(_loadedTime) && !!_loadedTime && [_loadedTime timeIntervalSinceNow]<-30;
        return outDated;
    }else {
        return _path && (nil == _loadedTime);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
    [_sessionTask cancel];
    _sessionTask = nil;
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
    // DO NOTHING, right now
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(NSURLSessionTask *)task {
    _sessionTask = task;
    
    [self didStartLoad];
}

- (void)requestDidFinishLoad:(NSURLSessionTask *)task withObject: (id) object continueLoad:(BOOL)continueLoad{
    
    // continueLoad表示request是不是还在请求中，如果请求中，则不会置为nil
    _isLoading = NO;
    if (!self.isLoadingMore) {
        _loadedTime = [NSDate date];
        
    }
    
    if (!continueLoad) {
        _sessionTask = nil;
    }
    
    [self didFinishLoadWithObject: object];
}

- (void)request:(NSURLSessionTask *)task didFailLoadWithError:(NSError*)error {
    _sessionTask = nil;
    _isLoading = NO;
    [self didFailLoadWithError:error];
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidCancelLoad:(NSURLSessionTask *)task {
    _sessionTask = nil;
    _isLoading = NO;
    [self didCancelLoad];
}

@end
