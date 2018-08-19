//
//  NSArray+ZXTool.h
//  BitFinance
//

#import <Foundation/Foundation.h>

@interface NSString (ZXTool)
// text
+ (BOOL)isEmpty:(NSString *)str;

@end


@interface NSArray (ZXTool)

- (id)safeObjectAtIndex:(NSInteger)index;

- (NSInteger)safeIndexOfObject:(id)obj;

+ (BOOL)isEmpty:(NSArray *)array;

@end


@interface NSMutableArray (ZXTool)

- (void)safeRemoveObjectAtIndex:(NSInteger)index;

- (void)safeAddObject:(id)obj;

@end



