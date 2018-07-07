//
//  NSArray+ZXTool.m
//  BitFinance
//

#import "NSArray+ZXTool.h"

@implementation NSString (ZXTool)

+ (BOOL)isEmpty:(NSString *)str {
    return !(str && [str isKindOfClass:[NSString class]] && str.length &&![str isEqual:[NSNull null]]);
}
@end




@implementation NSArray (ZXTool)

- (id)safeObjectAtIndex:(NSInteger)index {
    if (index >= self.count || index < 0) {
        return nil;
    }
    return self[index];
}

- (NSInteger)safeIndexOfObject:(id)obj {
    if (obj == nil) {
        return 0;
    }
    return [self indexOfObject:obj];
}

+ (BOOL)isEmpty:(NSArray *)array {
    return !(array && [array isKindOfClass:[NSArray class]] && array.count && ![array isEqual:[NSNull null]]);
}

@end


@implementation NSMutableArray (ZXTool)

- (void)safeRemoveObjectAtIndex:(NSInteger)index {
    if (index >= self.count || index < 0) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeAddObject:(id)obj
{
    if (obj == nil) {
        return;
    }
    [self addObject:obj];
}

@end
