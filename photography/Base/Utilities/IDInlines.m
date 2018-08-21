//
//  XSInlines.m
//  XinSubstance
//
//  Created by zhangyuanqing on 16/7/10.
//  Copyright © 2016年 KeyWenderman. All rights reserved.
//

#import "IDInlines.h"
#import <UIKit/UIKit.h>

@implementation XSInlines

+ (NSString *)ensureNotNull:(id)src {
    return src ? src : @"";
}

NSString *GET_STRING(id originData) {
    if ([originData isKindOfClass: [NSString class]]) {
        return originData;
    }else if (!originData || [originData isKindOfClass: [NSNull class]]) {
        return @"";
    } else {
        return [NSString stringWithFormat: @"%@", originData];
    }
}

NSString* SODescriptionForResponceObject(id responceObject) {
    if ([responceObject isKindOfClass: [NSDictionary class]]) {
        
        return responceObject[@"error_message"];
    } else {
        return @"未知错误";
    }
}

CGRect SNScreenBounds() {
    // 屏幕的大小（相对于当前的Orientation)
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}


CGFloat viewWidth() {
    static CGFloat viewWidth = 0;
    if (viewWidth == 0) {

        viewWidth = SNScreenBounds().size.width;
        
    }
    
    return viewWidth;
}

CGFloat NIToolbarHeightForOrientation(UIInterfaceOrientation orientation) {
    return  (UIInterfaceOrientationIsPortrait(orientation)
               ? 44
               : 33);
}

CGRect SNNavigationFrame() {
    // application所在Rect的高度
    //    CGRect frame = ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? [UIScreen mainScreen].bounds : [UIScreen mainScreen].applicationFrame;
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    CGFloat toolbarHeight = NIToolbarHeightForOrientation([UIApplication sharedApplication].statusBarOrientation);
    
    CGRect rect =  CGRectMake(0, 0, frame.size.width, frame.size.height - toolbarHeight);
    // NIDPRINT(@"SNNavigationFrame Height: %.1f", rect.size.height);
    
    return rect;
}

CGFloat SNNavigationFrameHeight() {
    return SNNavigationFrame().size.height;
}

CGFloat SNLeftEdge(CGFloat wholeWidth, CGFloat localWidth) {
    return (wholeWidth - localWidth)/2.0;
}

BOOL SNOveriOS(CGFloat version) {
    return ([[UIDevice currentDevice].systemVersion floatValue] >= version);
}

void SwizzleClassMethod(id c, SEL orig, SEL new1, BOOL isClassMethod) {
    
    if (isClassMethod) {
        Method origMethod = class_getClassMethod(c, orig);
        Method newMethod = class_getClassMethod(c, new1);
        
        c = object_getClass((id)c);
        
        if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
            class_replaceMethod(c, new1, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        else {
            method_exchangeImplementations(origMethod, newMethod);
        }
    } else {
        
        Method original, swizzled;
        
        original = class_getInstanceMethod(c, orig);
        swizzled = class_getInstanceMethod(c, new1);
        method_exchangeImplementations(original, swizzled);
        
    }
}


@end
