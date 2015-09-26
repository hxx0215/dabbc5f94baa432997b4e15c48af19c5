//
//  NSNumber+Cmp2String.m
//  edecorate
//
//  Created by shadowPriest on 15/7/13.
//
//

#import "NSNumber+Cmp2String.h"

@implementation NSNumber (Cmp2String)

- (BOOL)isEqualToString:(NSString *)st{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    return [self isEqual:[f numberFromString:st]];
}
@end
