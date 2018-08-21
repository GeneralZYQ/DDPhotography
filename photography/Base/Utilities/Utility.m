//
//  Utility.m
//  BeautifulGirls
//
//  Created by suning on 14-10-5.
//  Copyright (c) 2014年 BestBoys. All rights reserved.
//

#import "Utility.h"
#import "NSString+URLEncoding.h"
#import "UIView+sunny.h"

@import AdSupport.ASIdentifierManager;

static NSMutableDictionary* urlSpecialChars = nil;

@implementation Utility

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
						   andText:(NSString *)text
					   andFontSize:(CGFloat)fontSize {
	static UILabel * label = nil;
	if ( label==nil ) {
		label = [[UILabel alloc] initWithFrame:CGRectZero];
	}
    
    
    label.font = [UIFont systemFontOfSize: fontSize];
    label.frame = CGRectMake(0, 0, width, 0);
    label.numberOfLines = 0;
    label.text = text;
    [label sizeToFit];
    
    return label.height;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat) getLabelHeightWithWidth:(CGFloat)width andText:(NSString *)text andFont:(UIFont*)font{
    static UILabel* label = nil;
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    label.font = font;
    label.frame = CGRectMake(0, 0, width, 0);
    label.numberOfLines = 0;
    
    label.text = text;
    [label sizeToFit];
    
    return label.height;
}

+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
                           andText:(NSString *)text
                       andFontSize:(CGFloat)fontSize
                     numberOfLines:(NSInteger)numberOfLines {
//    static UILabel * label = nil;
//    if ( label==nil ) {
//        label = [[UILabel alloc] initWithFrame:CGRectZero];
//    }
//    
//    
//    label.font = [UIFont systemFontOfSize: fontSize];
//    label.frame = CGRectMake(0, 0, width, 0);
//    label.numberOfLines = numberOfLines;
//    
//    label.text = text;
//    [label sizeToFit];
    
    return [Utility getLabelHeightWithWidth: width
                                    andText: text
                                    andFont: [UIFont systemFontOfSize: fontSize]
                              numberOfLines: numberOfLines];
}

+ (CGFloat)getLabelHeightWithWidth:(CGFloat)width
                           andText:(NSString *)text
                           andFont:(UIFont*)font
                     numberOfLines:(NSInteger)numberOfLines {
    static UILabel * label = nil;
    if ( label==nil ) {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    
    label.font = font;
    label.frame = CGRectMake(0, 0, width, 0);
    label.numberOfLines = numberOfLines;
    
    label.text = text;
    [label sizeToFit];
    
    return label.height;
}

+ (CGFloat) getLabelWidthText:(NSString *)text andFont:(UIFont*)font{
    static UILabel* label = nil;
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    
    label.font = font;
    label.frame = CGRectMake(0, 0, 0, 0);
    label.numberOfLines = 1;
    
    label.text = text;
    [label sizeToFit];
    
    return label.width;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)getDocumentPath {
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)getFilePath:(NSString *)fileName {
	NSString * documentPath = [self getDocumentPath];
	return [documentPath stringByAppendingPathComponent:fileName];
}

+ (NSString*)getTmpFilePath:(NSString *)fileName {
    return [NSTemporaryDirectory() stringByAppendingPathComponent: fileName];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)escapeURL:(NSString *)url {
	// Construct HashMap
	if (urlSpecialChars == nil ) {
        // TODO: 静态变量是否会出现内存泄露？
        // NSLog(@"Utility#escapeURL, Before Dictionaly is initialized");
        urlSpecialChars = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                           @"%22", @"\"",
                           @"%3C", @"<",
                           @"%3E", @">",
                           @"%5C", @"\\",
                           @"%5E", @"^",
                           @"%5B", @"[",
                           @"%5D", @"]",
                           @"%60", @"`",
                           @"%2B", @"+",
                           @"%24", @"$",
                           @"%2C", @",",
                           @"%40", @"@",
                           @"%3A", @":",
                           @"%3B", @";",
                           @"%2F", @"/",
                           @"%21", @"!",
                           @"%23", @"#",
                           @"%3F", @"?",
                           @"%3D", @"=",
                           @"%26", @"&",
                           nil
                           ];
        // NSLog(@"Utility#escapeURL, After Dictionaly is initialized");
	}
    
	NSMutableString * str1 = [NSMutableString stringWithCapacity:0];
	[str1 appendString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableString * str2 = [NSMutableString stringWithCapacity:0];
    
	// 遍历str1中的每一个字符，并且进行可能的替换
	NSInteger str1Len = [str1 length];
	NSRange range;
	range.length = 1;
    
    // NSLog(@"Utility#escapeURL, Before Escape: %@", str1);
	for (int i = 0; i < str1Len; ++i) {
		range.location = i;
        NSString* key = [str1 substringWithRange:range];
        
        // NSLog(@"Utility#escapeURL, Key: %@", key);
        
        //"@"比较特殊
        // Use objectForKey instead of valueForKey to avoid KeyValueConversion, in which case "@" is for special use
		NSString* subStr = [urlSpecialChars objectForKey:key];
        // NSLog(@"Utility#escapeURL, Value: %@", subStr);
        
		if (subStr != nil)
			[str2 appendString:subStr];
		else
			[str2 appendString:key];
	}
    // NSLog(@"Utility#escapeURL, After Escape: %@", str2);
	return str2;
}

+ (NSDate*) dateWithFormatter:(NSString*) formatter time:(NSString*) time {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter dateFromString: time];
}

// 例如: @"yyyy-MM-dd"
//
+ (NSString*) stringWithFormatter:(NSString*) formatter time:(NSDate*) date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return [dateFormatter stringFromDate: date];
}

+ (id)userDefaultObjectForKey:(NSString *)key {
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    return [info objectForKey:key];
}

+ (void)setUserDefaultObjects:(NSDictionary *)dict {
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [info setObject:obj forKey:key];
    }];
    [info synchronize];
}


+ (void)removeUserDefaultKeyList:(NSArray<NSString *> *)keys {
    NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
    for (NSString *key in keys) {
        [info removeObjectForKey:key];
    }
    [info synchronize];
}


//
// 不是设备Id, 每次都成圣一个全球唯一的字符串
//
+ (NSString*) getUUID {
    
    static NSString *UUIDString = nil;
    if ([UUIDString isNonEmpty]) {
        return UUIDString;
    }
    
    //
    // https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSUUID_Class/Reference/Reference.html
    // NSUUID为128-bit, 全球唯一(Globally Unique Identifiers)
    // 经过HEX编码之后变成32个字节的字符串
    //
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        UUIDString = [[NSUUID UUID] UUIDString];
    } else {
        CFUUIDRef UUID = CFUUIDCreate(NULL);
        UUIDString = CFBridgingRelease(CFUUIDCreateString(NULL, UUID));
    }
    
    UUIDString = [UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (![UUIDString isNonEmpty]) {
        return @"";
    } else {
        return UUIDString;
    }
}

+ (NSString*) getIdfa {
    
    // 3. 读取 adid
    if (([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)) {
        
        // 加了判断，用户是否打开了idfa开关
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *adid = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString] ;
            if ([adid isNonEmpty]) {
                adid = [adid stringByReplacingOccurrencesOfString:@"-" withString: @""];
            }
            // 如果adid全部都是0, 则放弃
            if ([adid isNonEmpty]) {
                // 如果adid全部都是0, 则表示不合法
                BOOL isValid = NO;
                for (int i = 0; i < adid.length; i++) {
                    NSString* ch = [adid substringWithRange: NSMakeRange(i, 1)];
                    if (![ch isEqualToString:@"0"]) {
                        isValid = YES;
                    }
                }
                if (isValid) {
                    return adid;
                }
            }
        } else {
            return @"";
        }
    }
    return @"";
}

+ (NSString*)uniqueDeviceToken {
    
    @synchronized(self) {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"]) {
            return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
        }
        
        
        NSString* uuid = [Utility getUUID];
        uuid =  [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"deviceID"];
        
        //        NIDPRINT(@"UniqueDeviceToken: ====> %@ <====", uniqueDeviceToken);
        return uuid;
    }
}

+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


@end
