
#import "GYUpdateVersionHelper.h"
#import "GYUpdateSoftwareAlert.h"

@interface GYUpdateVersionHelper()

@end

@implementation GYUpdateVersionHelper

+(instancetype)shareInstance
{
    static GYUpdateVersionHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GYUpdateVersionHelper alloc]init];
    });
    return instance;
}



-(void)demo_checkNetSoftwareUpdate{
        UpdateVersionModel *model = [UpdateVersionModel new];
        model.mustUp = 1;
        model.showTxt = @"1、alert弹出效果可选择弹性效果或 无弹性效果\n2、可自定义控制关闭按钮的位置\n3、可选强制更新或在非强制\n4、弹性效果来源于POPSpringAnimation动画；";
        if(model && [model isKindOfClass:[UpdateVersionModel class]]){
            
            if(model.mustUp == 0){
                
                //非强制更新，记录弹窗日期（一天只弹一次）
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                NSString *formatStr = @"yyyy-MM-dd";
                dateFormat.dateFormat = formatStr;
                
                //如果当天已经弹窗过，则不再请求
                NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *oldDateString = [defaults objectForKey:@"VersonUpdateDate"];
                if (oldDateString && [oldDateString isEqualToString:dateString]) {
                    return;
                }
            
                NSString *dateStringNew = [dateFormat stringFromDate:[NSDate date]];
                [[NSUserDefaults standardUserDefaults] setObject:dateStringNew forKey:@"VersonUpdateDate"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        
            GYUpdateSoftwareAlert *updateAlert = [[GYUpdateSoftwareAlert alloc] initWithModel:model];
            updateAlert.mustUpdateFlag = model.mustUp;
            updateAlert.clickGoAppStoreBtnBlock = ^{
                //跳转去更新app
                
                NSString *urlStr = model.downloadUrl?:@"";
                NSString *appURLStr= [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURLStr] options:@{} completionHandler:nil];
            };
            [updateAlert show];
        }
}

//版本更新检查
- (void)checkNewAPPVersion {
   
    [self  demo_checkNetSoftwareUpdate];
}
@end
