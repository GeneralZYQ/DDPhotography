//
//  SNTimerHolder.m
//  SpeakOut
//
//  Created by sunny on 14-12-5.
//  Copyright (c) 2014年 51tallk. All rights reserved.
//

#import "SNTimerHolder.h"

@implementation SNTimerHolder {
    BOOL _repeats;
    NSTimeInterval _seconds;
}

- (void)dealloc {
    [self stopTimer];
}

- (void)startTimer: (NSTimeInterval)seconds
          delegate: (id<SNTimerDelegate>)delegate
           repeats: (BOOL)repeats {
    _timerDelegate = delegate;
    _repeats = repeats;
    _seconds = seconds;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (!_needAllRunloops) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                                  target:self
                                                selector:@selector(onTimer:)
                                                userInfo:nil
                                                 repeats:repeats];
    }else {
        _timer = [NSTimer timerWithTimeInterval: seconds
                                         target: self
                                       selector: @selector(onTimer:)
                                       userInfo: nil
                                        repeats: repeats];
        [[NSRunLoop currentRunLoop] addTimer: _timer
                                     forMode: NSRunLoopCommonModes];
    }
    
}


//立刻开始执行
- (void)fire{
    
    _fireCount++;
    
    if (_timer) {
        [_timer fire];
    }
}
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
    _timerDelegate = nil;
    _fireCount = 0;
}

- (void)onTimer: (NSTimer *)timer {
//    NIDPRINTMETHODNAME();
    
    _fireCount++;
    
    if (!_repeats) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (_timerDelegate && [_timerDelegate respondsToSelector:@selector(onTimerFired:)]) {
        [_timerDelegate onTimerFired:self];
    }
}

- (void)restart {
    
    if (_seconds != 0 && _timerDelegate) {
        [self startTimer:_seconds delegate:_timerDelegate repeats:_repeats];
    }
}

@end
