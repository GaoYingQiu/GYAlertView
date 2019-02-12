//
//  YDYUpdateSoftware.h
//  ydy
//
//  Created by qiugaoying on 2018/1/11.
//  Copyright © 2017年 XX. All rights reserved.
//

#import "GYButton.h"
#import <Foundation/Foundation.h>
//自定义系统AlertView
#define QiuAlertTitleColor @"titleColor"
#define QiuAlertContentColor @"contentColor"

@interface QiuAlertView : NSObject

@property (nonatomic,copy) void (^clickOkBtnBlock)(void);
@property (nonatomic,copy) void (^clickCancelBtnBlock)(void);

-(instancetype)initWithTitle:(NSString *)titleStr contentMessage:(NSString *)messageStr cancelTitle:(NSString *)cancelTitleStr confirmTitle:(NSString *)confirmTitleStr colorSettingDic:(NSDictionary *)colorDic;

-(void)show;
@end
