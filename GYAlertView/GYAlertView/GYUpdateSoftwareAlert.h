

#import <UIKit/UIKit.h>
#import "UpdateVersionModel.h"

@interface GYUpdateSoftwareAlert : UIView

@property (nonatomic,copy) void (^clickGoAppStoreBtnBlock)(void);
@property (nonatomic,copy) void (^clickCloseBtnBlock)(void);

@property (nonatomic,assign) NSInteger mustUpdateFlag; //1为强制更新

-(instancetype)initWithModel:(UpdateVersionModel *)model;

-(void)show;
@end
