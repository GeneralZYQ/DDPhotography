//
//  XSModel.h
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NINonRetainingCollections.h"

typedef enum {
    SNURLRequestCachePolicyNone    = 0,
    SNURLRequestCachePolicyMemory  = 1,
    SNURLRequestCachePolicyDisk    = 2,
    SNURLRequestCachePolicyNetwork = 4,
    SNURLRequestCachePolicyNoCache = 8,
    
    SNURLRequestCachePolicyEtag    = 16 | SNURLRequestCachePolicyDisk,
    
    // Local: 内存 + Disk
    SNURLRequestCachePolicyLocal   = (SNURLRequestCachePolicyMemory | SNURLRequestCachePolicyDisk),
    // 默认: 内存 + Disk + 网络
    SNURLRequestCachePolicyDefault = (SNURLRequestCachePolicyMemory | SNURLRequestCachePolicyDisk |SNURLRequestCachePolicyNetwork),
} SNURLRequestCachePolicy;

@protocol IDModelDelegate <NSObject>

// TTModelDelegate 的各种实现
- (NSMutableArray*)delegates;

// 数据是否加载，默认为YES
- (BOOL)isLoaded;

// 是否正在加载中: 默认为NO
- (BOOL)isLoading;

// 是否在加载更多: 默认为NO
- (BOOL)isLoadingMore;

// 数据是否过期，默认为NO
- (BOOL)isOutdated;

// 加载数据: 默认啥都不做
- (void)load:(SNURLRequestCachePolicy)cachePolicy more:(BOOL)more;

// 取消当前的网络请求
- (void)cancel;

// 从缓存中删除数据, 默认啥都不做
- (void)invalidate:(BOOL)erase;

// 重置model的状态
- (void) reset;

@end

@interface IDModel : NSObject <IDModelDelegate> {
    NSMutableArray* _delegates;
}

// 通知delegates开始下载
- (void)didStartLoad;

// 通知delegates下载完成，其中object为解析出来的结果，例如: http data, json, xml等
- (void)didFinishLoadWithObject: (id) object;

// 通知delegates下载失败, 其中error为失败的内容
- (void)didFailLoadWithError:(NSError*)error;

// 通知delegates下载取消
- (void)didCancelLoad;

// 通知delegates开始updates
- (void)beginUpdates;

// 通知delegates结束updates
- (void)endUpdates;

// Notifies delegates that the model changed in some fundamental way.
- (void)didChange;

@end
