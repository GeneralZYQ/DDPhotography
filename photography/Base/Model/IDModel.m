//
//  XSModel.m
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDModel.h"
#import "NSArray+Additions.h"

@implementation IDModel

- (NSMutableArray*)delegates {
    if (nil == _delegates) {
        _delegates = NICreateNonRetainingMutableArray();
    }
    return _delegates;
}

- (BOOL)isLoaded {
    return YES;
}

- (BOOL)isLoading {
    return NO;
}

- (BOOL)isLoadingMore {
    return NO;
}

- (BOOL)isOutdated {
    return NO;
}

- (void)load:(SNURLRequestCachePolicy)cachePolicy more:(BOOL)more {
}

- (void)cancel {
}

- (void) reset {
}

- (void)invalidate:(BOOL)erase {
}

- (void)didStartLoad {
    [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
}

- (void)didFinishLoadWithObject: (id) object {
    // 将TTModel的状态传递给delegates
    [_delegates perform:@selector(modelDidFinishLoad:withObject:) withObject:self withObject: object];
}

- (void)didFailLoadWithError:(NSError*)error {
    // 将TTModel的状态传递给delegates
    [_delegates perform:@selector(model:didFailLoadWithError:) withObject:self
             withObject:error];
}

- (void)didCancelLoad {
    [_delegates perform:@selector(modelDidCancelLoad:) withObject:self];
}

- (void)beginUpdates {
    [_delegates perform:@selector(modelDidBeginUpdates:) withObject:self];
}

- (void)endUpdates {
    [_delegates perform:@selector(modelDidEndUpdates:) withObject:self];
}

- (void)didChange {
    [_delegates perform:@selector(modelDidChange:) withObject:self];
}

@end
