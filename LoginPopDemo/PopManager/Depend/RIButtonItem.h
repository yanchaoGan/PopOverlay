//
//  RIButtonItem.h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RIButtonItem : NSObject {
    NSString *label;
    void (^action)();
}

//feature 可以修改这里的按钮显示样式
@property (nonatomic, strong) UIButton *button;

//按钮配置信息
@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)();
@property (copy, nonatomic) void(^showStyle)(RIButtonItem *style);

+ (id)item;
+ (id)itemWithLabel:(NSString *)inLabel;
+ (id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action;

@end

