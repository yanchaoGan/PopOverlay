//
//  UIView+Ext.m
//  69Show
//
//  Created by quyou on 14-8-6.
//  Copyright (c) 2014年 郑福利. All rights reserved.
//

#import "UIView+Ext.h"

static NSString * maskLayerKey;
@implementation UIView (Ext)

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}


// Retrieve and set the origin
- (CGPoint) origin
{
	return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
	return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
	return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
	CGRect newframe = self.frame;
	newframe.size.height = newheight;
	self.frame = newframe;
}

- (CGFloat) width
{
	return self.bounds.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
	CGRect newframe = self.frame;
	newframe.size.width = newwidth;
	self.frame = newframe;
}

- (CGFloat) top
{
	return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
	CGRect newframe = self.frame;
	newframe.origin.y = newtop;
	self.frame = newframe;
}

- (CGFloat) left
{
	return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
	CGRect newframe = self.frame;
	newframe.origin.x = newleft;
	self.frame = newframe;
}

- (CGFloat) bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
	CGRect newframe = self.frame;
	newframe.origin.y = newbottom - self.frame.size.height;
	self.frame = newframe;
}

- (CGFloat) right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
	CGRect newframe = self.frame;
	newframe.origin.x += delta ;
	self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}
-(void)autoResizeAllMask{
    self.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin|
        UIViewAutoresizingFlexibleRightMargin|
        UIViewAutoresizingFlexibleTopMargin|
        UIViewAutoresizingFlexibleBottomMargin|
        UIViewAutoresizingFlexibleWidth|
        UIViewAutoresizingFlexibleHeight;
}

- (void)viewRemoveGradient {
    id gralayer = objc_getAssociatedObject(self, &maskLayerKey);
    if (gralayer) {
        [(CALayer *)gralayer  removeFromSuperlayer];
    }
}

/**
 UIView背景渐变颜色
 
 @param colors 渐变颜色（必须是id类型）
 @param startPoint 渐变开始
 @param endPoint 渐变结束
 */
- (void)viewAddGradientRampWithColors:(NSArray *)colors rect:(CGRect)rect startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    id gralayer = objc_getAssociatedObject(self, &maskLayerKey);
    if (gralayer) {
        [(CALayer *)gralayer  removeFromSuperlayer];
    }
    //在后面添加渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.colors = colors;

    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    [self.layer insertSublayer:gradientLayer atIndex:0];

    objc_setAssociatedObject(self, &maskLayerKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)viewAddGradientLayerWitColors:(NSArray * )colors locations:(NSArray *)locations inRect:(CGRect)rect {
    id gralayer = objc_getAssociatedObject(self, &maskLayerKey);
    if (gralayer) {
        [(CALayer *)gralayer  removeFromSuperlayer];
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;  // 设置显示的frame
    gradientLayer.colors = colors;  // 设置渐变颜色
    gradientLayer.locations = locations;// 颜色的起点位置，递增，并且数量跟颜色数量相等
    
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    [self.layer addSublayer:gradientLayer];
    objc_setAssociatedObject(self, &maskLayerKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 UIView添加圆角
 
 @param corners 圆角位置
 @param cornerRadii 圆角半角
 */
- (void)viewCirclePathByRoundingCorners:(UIRectCorner)corners corner:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 UIView添加圆角
 
 @param corners 圆角位置
 @param cornerRadii 圆角半角
 @param rect   控件frame
 */
- (void)viewCirclePathByRoundingCorners:(UIRectCorner)corners rect:(CGRect)rect corner:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 UiView平移

 @param moveView 移动View
 @param duratin 动画时间
 @param toValue 运动到的为止
 */
+ (void)moveAnimationView:(UIView *)moveView animationDuration:(CFTimeInterval)duratin animationToValue:(CGFloat)toValue {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"]; // 设置动画方式沿着X轴
    positionAnimation.toValue = [NSNumber numberWithFloat:toValue];
    positionAnimation.duration = duratin;
    positionAnimation.repeatCount = MAXFLOAT;
    positionAnimation.autoreverses = YES;
    
    [moveView.layer addAnimation:positionAnimation forKey:@"position"];
}

- (void)addDarkEffectViewWithFrame:(CGRect)rect{
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    visualEffectView.frame = rect;
    [self addSubview:visualEffectView];
    [self sendSubviewToBack:visualEffectView];
}

@end
