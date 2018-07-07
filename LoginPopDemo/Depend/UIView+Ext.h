//
//  UIView+Ext.h
//  69Show
//
//  Created by quyou on 14-8-6.
//  Copyright (c) 2014年 郑福利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

-(void)autoResizeAllMask;

/**
 UIView背景渐变颜色

 @param colors 渐变颜色（必须是id类型）
 @param startPoint 渐变开始
 @param endPoint 渐变结束
 */
- (void)viewAddGradientRampWithColors:(NSArray *)colors rect:(CGRect)rect startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (void)viewAddGradientLayerWitColors:(NSArray *)colors locations:(NSArray *)locations inRect:(CGRect)rect;


/**< 删除刚添加的渐变色*/
- (void)viewRemoveGradient;

/**< 加圆角*/
- (void)viewCirclePathByRoundingCorners:(UIRectCorner)corners corner:(CGSize)cornerRadii;

/**
 加一个蒙版

 @param rect 蒙版的frame
 */
- (void)addDarkEffectViewWithFrame:(CGRect)rect;

@end
