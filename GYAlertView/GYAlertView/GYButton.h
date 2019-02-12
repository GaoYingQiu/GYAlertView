//
//  QTButton.h
//  ydy
//
//  Created by 邱高颖 on 2017/7/12.
//  Copyright © 2017年 邱高颖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonType) {
    kButtonTypeNone = 0,
};

typedef void (^QTBtnVoidBlock)(void);


@interface GYButton : UIButton

- (void)addActionWithBlock:(QTBtnVoidBlock)actionBlock;
+ (instancetype)buttonWithFrame:(CGRect)frame
                           type:(ButtonType)buttonType
                         action:(QTBtnVoidBlock)actionBlock;
@end
