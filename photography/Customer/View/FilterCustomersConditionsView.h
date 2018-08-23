//
//  FilterCustomersConditionsView.h
//  photography
//
//  Created by 张元清 on 2018/8/22.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterCustomersConditionsViewDelegate<NSObject>

- (void)conditionsViewDidSelectConditionsTypes:(NSArray *)types ratings:(NSArray *)ratings;

@end

@interface FilterCustomersConditionsView : UIView

@property (nonatomic, weak) id<FilterCustomersConditionsViewDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *weddingButton;
@property (nonatomic, weak) IBOutlet UIButton *publicButton;
@property (nonatomic, weak) IBOutlet UIButton *activityButton;

@property (nonatomic, weak) IBOutlet UIButton *bestButton;
@property (nonatomic, weak) IBOutlet UIButton *goodButton;
@property (nonatomic, weak) IBOutlet UIButton *badButton;

- (void)showInWindow;

@end
