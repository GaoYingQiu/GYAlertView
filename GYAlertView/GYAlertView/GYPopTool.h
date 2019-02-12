#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  关闭按钮的位置
 */
typedef NS_ENUM(NSInteger, ButtonPositionType) {
    
    ButtonPositionTypeNone = 0,
    ButtonPositionTypeLeft = 1 << 0,
    ButtonPositionTypeRight = 2 << 0,
    ButtonPositionTypeBottomCenter = 3 << 0
};

typedef enum : NSUInteger {
    AnimationDirectionAlert,
    AnimationDirectionAlertSpring
} AnimationDirectionType;

/**
 *  蒙板的背景色
 */
typedef NS_ENUM(NSInteger, ShadeBackgroundType) {
    /**
     *  渐变色
     */
    ShadeBackgroundTypeGradient = 0,
    /**
     *  固定色
     */
    ShadeBackgroundTypeSolid = 1 << 0
};

typedef void(^completeBlock)(void);
typedef void(^CloseBtnClickedBlock)(void);

@interface GYPopTool : NSObject

@property (strong, nonatomic) UIColor *popBackgroudColor;//弹出视图的背景色
@property (assign, nonatomic) BOOL tapOutsideToDismiss;//点击蒙板是否弹出视图消失
@property (assign, nonatomic) ButtonPositionType closeButtonType;//关闭按钮的类型
@property (assign, nonatomic) CGFloat customerTopOffsetY;

@property (assign, nonatomic) AnimationDirectionType animationDirectionType; //动画效果
@property (assign, nonatomic) ShadeBackgroundType shadeBackgroundType;//蒙板的背景色
@property (strong, nonatomic) CloseBtnClickedBlock closeBtnBlock;

/**
 *  创建一个实例
 *
 *  @return CHWPopTool
 */
+ (GYPopTool *)sharedInstance;
/**
 *  弹出要展示的View
 *
 *  @param presentView show View
 *  @param animated    是否动画
 */
- (void)showWithPresentView:(UIView *)presentView animated:(BOOL)animated;
/**
 *  关闭弹出视图
 *
 *  @param complete complete block
 */
- (void)closeWithBlcok:(void(^)(void))complete;

- (void)close; 
@end

