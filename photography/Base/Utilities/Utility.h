//
//  Utility.h
//  BeautifulGirls
//
//  Created by suning on 14-10-5.
//  Copyright (c) 2014年 BestBoys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#define RGBCOLOR_HEX(hexColor) [UIColor colorWithRed: (((hexColor >> 16) & 0xFF))/255.0f         \
green: (((hexColor >> 8) & 0xFF))/255.0f          \
blue: ((hexColor & 0xFF))/255.0f                 \
alpha: 1]

@interface Utility : NSObject

+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
						   andText:(NSString *)text
					   andFontSize:(CGFloat)fontSize;

+ (CGFloat) getLabelHeightWithWidth:(CGFloat)width
                            andText:(NSString *)text
                            andFont:(UIFont*)font;

+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
                           andText:(NSString *)text
                       andFontSize:(CGFloat)fontSize
                     numberOfLines:(NSInteger)numberOfLines;

+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
                           andText:(NSString *)text
                           andFont:(UIFont*)font
                     numberOfLines:(NSInteger)numberOfLines;

+ (CGFloat) getLabelWidthText:(NSString *)text
                      andFont:(UIFont*)font;

// 获取App自己对应的文档目录
+ (NSString *)getDocumentPath;

+ (NSString *)getFilePath:(NSString *)fileName;

+ (NSString *)getTmpFilePath:(NSString*)fileName;

+ (NSString *)escapeURL:(NSString *)url;

+ (NSDate*) dateWithFormatter:(NSString*) formatter time:(NSString*) time;

+ (NSString*) stringWithFormatter:(NSString*) formatter time:(NSDate*) date;

+ (id)userDefaultObjectForKey:(NSString *)key;

+ (void)setUserDefaultObjects:(NSDictionary *)dict;

+ (void)removeUserDefaultKeyList:(NSArray<NSString *> *)keys;

+ (NSString*) getUUID;

+ (NSString*) getIdfa;

+ (NSString*)uniqueDeviceToken;

+ (BOOL) isCameraAvailable;

@end
