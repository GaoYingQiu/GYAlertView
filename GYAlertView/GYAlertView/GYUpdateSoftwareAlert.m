
#import "GYUpdateSoftwareAlert.h"
#import "TTTAttributedLabel.h"
#import "GYPopTool.h"
#import <Masonry.h>

@implementation GYUpdateSoftwareAlert
{
    UIView *alertView ;
}

-(instancetype)initWithModel:(UpdateVersionModel *)model
{
    self = [super init];
    if (self) {
        
        NSString *contentStr = model.showTxt;
        
        CGFloat backViewWidth = [[UIScreen mainScreen] bounds].size.width - 60;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backViewWidth, 340)];
        backView.layer.cornerRadius = 3;
        backView.layer.masksToBounds = YES;
        backView.backgroundColor = [UIColor clearColor];
    
        
        UIImageView *cloudImageView = [[UIImageView alloc]init];
        cloudImageView.image = [UIImage imageNamed:@"img-upgrade"];
        [backView addSubview:cloudImageView];
        [cloudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.equalTo(@(126*backViewWidth/316));
            make.top.mas_equalTo(0);
        }];
 
        
        UIView *contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor whiteColor];
        [backView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cloudImageView.mas_bottom).offset(0);
            make.left.right.bottom.mas_equalTo(0);
        }];
 
        
        UIScrollView *contentScrollView = [[UIScrollView alloc]init];
        [contentView addSubview:contentScrollView];
        [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
              make.top.mas_equalTo(14);
        }];
        
        
        
        TTTAttributedLabel *versionDescLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        [contentScrollView addSubview:versionDescLabel];
        versionDescLabel.font = [UIFont systemFontOfSize:14];
        versionDescLabel.textColor = [UIColor colorWithWhite:0 alpha:0.8];
        versionDescLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        versionDescLabel.textAlignment = NSTextAlignmentLeft;
        versionDescLabel.numberOfLines = 0;
        versionDescLabel.lineSpacing = 7;
        [versionDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.width.equalTo(@(backViewWidth - 20*2));
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        }];
        
        [versionDescLabel setText:contentStr];
        
        UIButton *btn1 = nil;
        if(model.mustUp == 0){
            btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, [[UIScreen mainScreen] bounds].size.width -20, 44)];
            [btn1 setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
            [btn1 setTitleColor:[UIColor colorWithWhite:0 alpha:0.8] forState:UIControlStateNormal];
            [btn1.titleLabel setFont:[UIFont systemFontOfSize:18]];
            [btn1 setTitle:@"取消" forState:UIControlStateNormal];
            btn1.tag = 1000;
            [btn1 addTarget:self action:@selector(skipToAppStoreDoUpdate:) forControlEvents:UIControlEventTouchUpInside];
            [contentView addSubview:btn1];
            
            [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.mas_equalTo(0);
                make.height.equalTo(@45);
                make.top.equalTo(contentScrollView.mas_bottom).offset(20);
                make.width.equalTo(@(backViewWidth/2));
            }];
        }
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, [[UIScreen mainScreen]bounds].size.width -20, 44)];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:141/255.0f blue:1 alpha:1]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btn setTitle:@"马上升级" forState:UIControlStateNormal];
        btn.tag = 2000;
        if(model.mustUp == 1){
            btn.layer.cornerRadius = 2;
        }
        [btn addTarget:self action:@selector(skipToAppStoreDoUpdate:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if(btn1){
                 make.left.equalTo(btn1.mas_right).offset(0);
                 make.right.bottom.mas_equalTo(0);
            }else{
                make.left.mas_equalTo(20);
                make.right.bottom.mas_equalTo(-20);
            }
           
            make.height.equalTo(@45);
            make.top.equalTo(contentScrollView.mas_bottom).offset(20);
        }];
        
        alertView = backView;
    }
    return self;
}


-(void)show{
    [GYPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeGradient;
    [GYPopTool sharedInstance].tapOutsideToDismiss = NO;
    [GYPopTool sharedInstance].animationDirectionType =  AnimationDirectionAlert;

    //强制更新
    [GYPopTool sharedInstance].closeButtonType = ButtonPositionTypeNone;
    
    [[GYPopTool sharedInstance] showWithPresentView:alertView animated:YES];
    [GYPopTool sharedInstance].closeBtnBlock = ^() {
        if (self.clickCloseBtnBlock) {
            self.clickCloseBtnBlock();
        }
    };
}

-(void)skipToAppStoreDoUpdate:(UIButton *)sender
{
    [[GYPopTool sharedInstance] close];
    
    if(sender.tag == 2000){
        if(self.clickGoAppStoreBtnBlock){
            self.clickGoAppStoreBtnBlock();
        }
    }
}

@end
