//
//  FilterCustomersConditionsView.h
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterCustomersConditionsViewDelegate<NSObject>
@end

@interface FilterCustomersConditionsView : UIView

@property (nonatomic, weak) id<FilterCustomersConditionsViewDelegate> delegate;

- (void)showInWindow;

@end
