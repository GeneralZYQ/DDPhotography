//
//  DDMessage.h
//  photography
//
//  Created by 张元清 on 2018/8/17.
//  Copyright © 2018 Keywandermen. All rights reserved.
//

#import "IDObject.h"

@interface DDMessage : IDObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL read;

@end
