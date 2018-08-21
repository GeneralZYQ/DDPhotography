//
//  SNTimerHolder.h
//  SpeakOut
//
//  Created by sunny on 14-12-5.
//  Copyright (c) 2014年 51tallk. All rights reserved.
//

//
// 这个工具类是为了解决timer会强引用自己的target导致一些引用循环，通过这种方法从根本上解决了不会循环引用controller
//
#import <Foundation/Foundation.h>
@class SNTimerHolder;

@protocol SNTimerDelegate <NSObject>

//
// timer触发了方法
//
- (void) onTimerFired:(SNTimerHolder*) timerHolder;

@end

@interface SNTimerHolder : NSObject

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) id<SNTimerDelegate> timerDelegate;

@property (nonatomic) BOOL needAllRunloops;

// 总共执行了多少次，每次stop后这个count清零，如果是repeat的timer这个count会一直加上去
@property (nonatomic, readonly) NSInteger fireCount;

- (void)startTimer: (NSTimeInterval)seconds
          delegate: (id<SNTimerDelegate>)delegate
           repeats: (BOOL)repeats;
- (void)fire;//立刻执行
- (void)stopTimer;
- (void)restart; // 重新开始倒计时
@end
