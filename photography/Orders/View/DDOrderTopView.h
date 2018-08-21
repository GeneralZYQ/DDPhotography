//
//  DDOrderTopView.h
//  photography
//
//  Created by 张元清 on 2018/8/16.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDOrderTopViewDelegate <NSObject>

- (void)orderTopViewSearchButtonPressed;
- (void)orderTopViewAddButtonPressed;
- (void)orderTopViewTodoButtonPressed;
- (void)orderTopViewDoneButtonPressed;

@end

@interface DDOrderTopView : UIView

@property (nonatomic, weak) id<DDOrderTopViewDelegate> delegate;

@end

