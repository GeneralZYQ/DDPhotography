//
//  HWURLRequestModel.h
//  HeartWu
//
//  Created by zhangyuanqing on 16/7/11.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDModel.h"
@class IDAPIClient;
@class IDURLRequestModel;

// 将 SN_HTTP_PARSE_BLOCK 的实现转移到 _self的selector的实现，避免block引用过多的成员变量
#define ID_HTTP_PARSER_WITH_SELF_BAR()                                          \
^(id httpObject, SNURLRequestModel* model) {   \
[_self parseHttpResponse: httpObject withModel: model];                           \
}

typedef void (^ID_HTTP_PARSE_BLOCK)(id httpObject, IDURLRequestModel* model);

@interface IDURLRequestModel : IDModel {
    
@protected
    BOOL _isLoadingMore;
    NSURLSessionTask *_sessionTask;
    __weak IDAPIClient* _httpClient;
    
    
    BOOL _isPaged;
    
    int _timestamp;
    int _requestCount;      // 增量跟新时候request失败则最多请求三次
    
    NSMutableSet* _filterSet;
}

// 过滤JSON中的nsnull，便于保存，因为nsnull无法保存到文件里面
+ (id) getFilteredData:(id)JSON;

// modelChanged 默认为 NO, 如果为 YES, 在下一次加载时，无论是Load More, 还是Refresh都是从第一页加载起
@property (nonatomic) BOOL modelChanged;

@property (nonatomic, strong) Class className;

@property (nonatomic, strong) NSMutableArray *sections;

@property (nonatomic, strong) NSDate* loadedTime;

@property (nonatomic, strong) NSString* path;
@property (nonatomic, copy) ID_HTTP_PARSE_BLOCK customHttpObjectParser;
//@property (nonatomic, copy) SN_TABLE_ITEM_FACTORY tableItemFactory;

@property (nonatomic) BOOL isTimeSensitive;

@property (nonatomic) BOOL isLoading;
@property (nonatomic, assign) BOOL isLoaded; // 请求过一次数据
// 是否有更多的计算方法
@property (nonatomic) BOOL hasMore;

// 是否需要从文件加载预保存的内容
@property (nonatomic) BOOL loadFromFile;


@property (nonatomic, strong) id userInfo;

//
@property (nonatomic, strong) NSString* httpMethod;

//
// 需要加载的post参数
//
@property (nonatomic, strong) NSDictionary* parameters;


// 通过返回结果数是否为0，来判断是否有更多
//
@property (nonatomic) BOOL hasMoreByNonZero;

//
// 虑重所需要的key
//
@property (nonatomic, strong) NSString* filterKey;

@property (nonatomic) int startNum;
@property (nonatomic) int stepCount;
@property (nonatomic) int page;
@property (nonatomic) int startPage;

@property (nonatomic, copy) NSString *customString;

@property (nonatomic, copy) BOOL (^customOutDateBlock)(NSDate *loadedDate);

@property (nonatomic, strong) NSString* paramNameStartNum;
@property (nonatomic, strong) NSString* paramNameStepCount;
@property (nonatomic, strong ) NSString* paramNamePage;
@property (nonatomic, copy) NSString *paramNameCustomString;

// 设置Request的状态
- (void)reset;

- (void)cancelAll;

- (id) initWithBaseURL: (NSString*) path
         andHttpClient: (IDAPIClient*) client
               isPaged: (BOOL) isPaged
             withClass: (Class)className
          andHttpParse: (id<IDModelDelegate>) delegate
            parameters: (NSDictionary *)parameters;

@end
