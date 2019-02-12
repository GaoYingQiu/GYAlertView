//
//  YDYUpdateSoftware.m
//  ydy
//
//  Created by qiugaoying on 2018/1/11.
//  Copyright © 2017年 XX. All rights reserved.
//

#import "QiuAlertView.h"
#import <Masonry.h>
#import "TTTAttributedLabel.h"
#import "GYButton.h"
#import "GYPopTool.h"

#define leftPadding 25
#define leftMargin 46
#define ActionBottomHeight 45
#define ContainerWidth ([UIScreen mainScreen].bounds.size.width - 2*leftMargin)  //容器宽度
#define TitleMargin 20

@implementation QiuAlertView
{
    UIView *alertView ;
}


+(CGFloat)cellHeightForAttributeText:(NSString *)text font:(UIFont *)txtFont
{
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 5;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName : txtFont, NSParagraphStyleAttributeName : paragraphStyle}];
    
    
    CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:str withConstraints:CGSizeMake((ContainerWidth-2*leftPadding), MAXFLOAT) limitedToNumberOfLines:0];
    return size.height;
}


/**
 <#Description#>

 @param titleStr 标题
 @param messageStr 内容
 @param cancelTitleStr 取消
 @param confirmTitleStr 确定
 @param colorDic 颜色配置 {"titleColor":标题颜色值,@"contentColor":内容颜色值}
 @return return value description
 */
-(instancetype)initWithTitle:(NSString *)titleStr contentMessage:(NSString *)messageStr cancelTitle:(NSString *)cancelTitleStr confirmTitle:(NSString *)confirmTitleStr colorSettingDic:(NSDictionary *)colorDic
{
    self = [super init];
    if (self) {
        
        UIColor *titleColor = [UIColor colorWithWhite:1 alpha:0.9];
        UIColor *contentColor = [UIColor colorWithWhite:1 alpha:0.9];
        if(colorDic){
            if([colorDic objectForKey:QiuAlertTitleColor]){
                UIColor *colorVue = [colorDic objectForKey:QiuAlertTitleColor];
                titleColor = colorVue;
            }
            
            if([colorDic objectForKey:QiuAlertContentColor]){
                UIColor *colorVue =  [colorDic objectForKey:QiuAlertContentColor];
                contentColor = colorVue;
            }
        }
        
        CGFloat titleHeight = [titleStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].height;
        CGFloat contentHeight = [QiuAlertView cellHeightForAttributeText:messageStr font:[UIFont systemFontOfSize:16]];
        CGFloat totalHeight = TitleMargin+titleHeight+15+contentHeight+40+ActionBottomHeight;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ContainerWidth, totalHeight)];
        backView.layer.cornerRadius = 7;
        backView.layer.masksToBounds = YES;
        backView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.8];
        
        UIView *contentView1 = [[UIView alloc]init];
        contentView1.tag = 1009;
        [backView addSubview:contentView1];
        [contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(leftPadding);
            make.right.mas_equalTo(-leftPadding);
            make.bottom.mas_equalTo(-ActionBottomHeight);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = titleColor;
        titleLabel.text = titleStr;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel sizeToFit];
        [contentView1 addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(TitleMargin);
        }];
       
        TTTAttributedLabel *versionDescLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        [contentView1 addSubview:versionDescLabel];
        versionDescLabel.font = [UIFont systemFontOfSize:16];
        versionDescLabel.textColor = contentColor;
        versionDescLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        versionDescLabel.textAlignment = NSTextAlignmentCenter;
        versionDescLabel.numberOfLines = 0;
        versionDescLabel.lineSpacing = 5;
        [versionDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.equalTo(@(ContainerWidth-2*leftPadding));
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.bottom.mas_lessThanOrEqualTo(-10);
        }];
        [versionDescLabel setText:messageStr];
        
        UIView *lineView         = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
        [backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.equalTo(@0.65);
            make.bottom.mas_equalTo(-(ActionBottomHeight+0.65));
        }];
    
        UIView *footerView = [[UIView alloc]init];
        [backView addSubview:footerView];
        [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.equalTo(@(ActionBottomHeight));
        }];
        
        __weak typeof(self) weakSelf = self;
        GYButton *cancelButton  = nil;
        if(cancelTitleStr && cancelTitleStr.length >0){
            UIColor *normalColor      =  [UIColor colorWithWhite:1 alpha:0.6];
            UIColor *highlightedColor = [normalColor colorWithAlphaComponent:0.5f];
            cancelButton = [GYButton buttonWithFrame:CGRectZero type:kButtonTypeNone action:^{
                [weakSelf cancelEventAction];
            }];
            
            cancelButton.titleLabel.font  = [UIFont systemFontOfSize:18];
            [cancelButton setTitle:cancelTitleStr    forState:UIControlStateNormal];
            [cancelButton setTitleColor:normalColor  forState:UIControlStateNormal];
            [cancelButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
            [footerView addSubview:cancelButton];
            [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(0);
                make.height.equalTo(@(ActionBottomHeight));
                make.width.equalTo(@(backView.frame.size.width/2));
            }];
            
            UIView *vtLine         = [[UIView alloc] init];
            vtLine.backgroundColor = lineView.backgroundColor;
            [footerView addSubview:vtLine];
            [vtLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(footerView);
                make.top.bottom.mas_equalTo(0);
                make.width.equalTo(@0.65);
            }];
        }
        
        UIColor *normalColor      =  [UIColor orangeColor];
        UIColor *highlightedColor = [normalColor colorWithAlphaComponent:0.5f];
    
        GYButton *okButton = [GYButton buttonWithFrame:CGRectZero type:kButtonTypeNone action:^{
 
            [[GYPopTool sharedInstance] close];
            if(self.clickOkBtnBlock){
                self.clickOkBtnBlock();
            }
        }];
 
        okButton.titleLabel.font  =   [UIFont boldSystemFontOfSize:18.f];
        [okButton setTitle:confirmTitleStr    forState:UIControlStateNormal];
        [okButton setTitleColor:normalColor  forState:UIControlStateNormal];
        [okButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
        [footerView addSubview:okButton];
        if(cancelButton){
            [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.right.mas_equalTo(0);
                    make.height.equalTo(@(ActionBottomHeight));
                    make.left.equalTo(cancelButton.mas_right).offset(0.5);
            }];
        }else{
            [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.mas_equalTo(0);
                make.height.equalTo(@(ActionBottomHeight));
                make.left.mas_equalTo(0);
            }];
        }
        
        alertView = backView;
    }
    return self;
}


-(void)show{
    
    [GYPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
    [GYPopTool sharedInstance].closeButtonType = ButtonPositionTypeNone;
    [GYPopTool sharedInstance].tapOutsideToDismiss = NO;
    [GYPopTool sharedInstance].animationDirectionType = AnimationDirectionAlertSpring;
    [[GYPopTool sharedInstance] showWithPresentView:alertView animated:YES];
    [GYPopTool sharedInstance].closeBtnBlock = ^() {

    };
}

-(void)cancelEventAction
{
    [[GYPopTool sharedInstance] close];
    if(self.clickCancelBtnBlock){
        self.clickCancelBtnBlock();
    }
}

@end
