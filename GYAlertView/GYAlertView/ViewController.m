//
//  ViewController.m
//  GYAlertView
//
//  Created by qiugaoying on 2019/2/12.
//  Copyright © 2019年 qiugaoying. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "QiuAlertView.h"
#import "GYUpdateVersionHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton  *dateActionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateActionBtn setTitle:@"点击弹出" forState:0];
    dateActionBtn.layer.cornerRadius = 2;
    dateActionBtn.layer.masksToBounds = YES;
    dateActionBtn.backgroundColor = [UIColor blackColor];
    dateActionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [dateActionBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:dateActionBtn];
    [dateActionBtn addTarget:self action:@selector(clickAlertAction) forControlEvents:UIControlEventTouchUpInside];
    [dateActionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@70);
        make.height.equalTo(@40);
        make.top.mas_equalTo(60);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton  *softwareVersionCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [softwareVersionCheckBtn setTitle:@"版本更新" forState:0];
    softwareVersionCheckBtn.layer.cornerRadius = 2;
    softwareVersionCheckBtn.layer.masksToBounds = YES;
    softwareVersionCheckBtn.backgroundColor = [UIColor blackColor];
    softwareVersionCheckBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [softwareVersionCheckBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:softwareVersionCheckBtn];
    [softwareVersionCheckBtn addTarget:self action:@selector(showSoftwareUpdateAction) forControlEvents:UIControlEventTouchUpInside];
    [softwareVersionCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@70);
        make.height.equalTo(@40);
        make.top.equalTo(dateActionBtn.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view);
    }];
    
}

-(void)clickAlertAction
{
    QiuAlertView *alert = [[QiuAlertView alloc]initWithTitle:@"自定义AlertView" contentMessage:@"内容提示，支持多行显示，弹性效果，高度自适应" cancelTitle:@"取消" confirmTitle:@"确定" colorSettingDic:nil];
    alert.clickOkBtnBlock = ^{
          //确定；
    };
    alert.clickCancelBtnBlock = ^{
         //取消；
    };
    [alert show];
}

-(void)showSoftwareUpdateAction
{
    [[GYUpdateVersionHelper shareInstance] checkNewAPPVersion];
}

@end
