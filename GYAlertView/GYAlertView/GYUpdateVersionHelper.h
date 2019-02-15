
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GYUpdateVersionHelper : NSObject

+(instancetype)shareInstance;
- (void)checkNewAPPVersion;
@end
