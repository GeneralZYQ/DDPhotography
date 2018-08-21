//
//  DDCustomerFilterView.h
//  photography
//
//  Created by 张元清 on 2018/8/21.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDCustomerFilterViewDelegate<NSObject>

- (void)customerDidSearchName:(NSString *)name;
- (void)customerDidPressFilterButton;
- (void)customerDidPressAddButton;

@end

@interface DDCustomerFilterView : UIView

@property (nonatomic, weak) id<DDCustomerFilterViewDelegate> delegate;

@end
