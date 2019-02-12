//
//  QTButton.m
//  ydy
//
//  Created by 邱高颖 on 2017/7/12.
//  Copyright © 2017年 邱高颖. All rights reserved.
//

#import "GYButton.h"

#define QTBtnRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GYButton() {
    QTBtnVoidBlock buttonActionBlock;
    
    UIColor *backgroundColor,*titleLabelColor;
}

@end

@implementation GYButton

- (void)addActionWithBlock:(QTBtnVoidBlock)actionBlock {
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    buttonActionBlock = actionBlock;
}

//
+ (instancetype)buttonWithFrame:(CGRect)frame type:(ButtonType)buttonType action:(QTBtnVoidBlock)actionBlock {
    GYButton *btn = [GYButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    NSString *title = nil;
    UIColor *titleColor = [UIColor whiteColor];
    CGFloat fontSize = 14.0f;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn addActionWithBlock:actionBlock];
    return btn;
}


- (void)buttonAction:(id)sender {
    if (buttonActionBlock) {
        buttonActionBlock();
    }
}

- (void)setEnabled:(BOOL)enabled {
    if (!self.backgroundColor) {
        [super setEnabled:enabled];
        return;
    }
    
    if (backgroundColor == nil) {
        backgroundColor = self.backgroundColor;
    }
    
    if (titleLabelColor == nil) {
        titleLabelColor = self.titleLabel.textColor;
    }
    
    [super setEnabled:enabled];
    
    if (enabled) {
        self.backgroundColor = backgroundColor;
        self.titleLabel.textColor = titleLabelColor;
    }
    else
    {
        self.backgroundColor = QTBtnRGB16(0xc2c2c2);
        self.titleLabel.textColor = [UIColor whiteColor];
    }
}

@end
