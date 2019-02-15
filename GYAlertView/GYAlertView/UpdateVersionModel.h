
#import <Foundation/Foundation.h>

@interface UpdateVersionModel : NSObject

@property (nonatomic , strong) NSString * downloadUrl; //下载链接

@property (nonatomic)  int mustUp; //是否强制更新

@property (nonatomic , strong) NSString * showTxt; //更新内容

@end
