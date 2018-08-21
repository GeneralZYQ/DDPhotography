//
//  UIImage+Tint.h
//  SpeakOut
//
//  Created by LeiZhang on 13-6-12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage*) imageWithTintColor:(UIColor*) tintColor;
- (UIImage*) imageWithGradientTintColor:(UIColor*) tintColor;

+ (UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size ;

@end
