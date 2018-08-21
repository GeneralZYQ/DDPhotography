//
//  DDOrderDateView.h
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDOrderDateViewDelegate<NSObject>

- (void)orderDateViewMessageButtonPressed;

@end

@interface DDOrderDateView : UIView

@property (nonatomic, weak) id<DDOrderDateViewDelegate> delegate;
@property (nonatomic, strong) UIButton *messageButton;
- (void)reloadWithMonthCount:(NSInteger)count;


@end
