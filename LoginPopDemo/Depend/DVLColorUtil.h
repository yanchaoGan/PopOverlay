
#import <UIKit/UIKit.h>

#define DVLColorGen(aColorString) [UIColor colorFromString:aColorString]
#define DVLColorGenAlpha(aColorString, aAlpha) [UIColor colorFromString:aColorString alpha:aAlpha]


@interface UIColor(DVLUtil)

/**
 涨价颜色
 */
+ (UIColor *)colorForRise;

/**
 下跌颜色
 */
+ (UIColor *)colorForFall;

/**
 *  NSString -》 UIColor
 *
 *  @param aColorString normal:@“#AB12FF” or @“AB12FF” or gray: @"C7"
 *
 *  @return UIColor
 */
+ (UIColor *)colorFromString:(NSString *)aColorString;
/**
 *  NSString -》 UIColor with alpha
 *
 *  @param aColorString normal:@“#AB12FF” or @“AB12FF” or gray: @"C7"
 *  @param aAlpha       alpha 0-1.0
 *
 *  @return UIColor
 */
+ (UIColor *)colorFromString:(NSString *)aColorString alpha:(CGFloat)aAlpha;

/**
 *  UIColor -》 NSString
 *
 *  @param aColor UIColor
 *
 *  @return NSString（format: @“#AB12FF”）
 */
+ (NSString *)stringFromColor:(UIColor *)aColor;

@end
