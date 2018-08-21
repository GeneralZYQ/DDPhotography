//
//  XSInlines.h
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <objc/runtime.h>
#import "UIView+sunny.h"

@interface XSInlines : NSObject

// 定义一个和给定v 类型相同的Weak Ref.变量
#define SN_DEFINE_SELF_BAR(v)      \
__weak typeof(v) _self = v

NSString *GET_STRING(id originData);

//static inline NSString* ENSURE_NOT_NULL(id src) {
//    return src ? src : @"";
//}

+ (NSString *)ensureNotNull:(id)src;

static inline id SN_ENSURE_NOT_STRING(id src) {
    return [src isKindOfClass: [NSString class]] ? nil : src;
}

NSString* SODescriptionForResponceObject(id responceObject);

CGRect SNScreenBounds();

// 屏幕的宽度
CGFloat viewWidth();

CGRect SNNavigationFrame();
CGFloat SNNavigationFrameHeight();

CGFloat SNLeftEdge(CGFloat wholeWidth, CGFloat localWidth);

BOOL SNOveriOS(CGFloat version);

void SwizzleClassMethod(id c, SEL orig, SEL new1, BOOL isClassMethod);

@end
