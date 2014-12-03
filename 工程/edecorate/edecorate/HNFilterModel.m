//
//  HNFilterModel.m
//  edecorate
//
//  Created by 刘向宏 on 14-12-2.
//
//

#import "HNFilterModel.h"

@implementation HNFilterModel

-(id)init
{
    self = [super init];
    self.goodsType1 = TRUE;
    self.goodsType2 = TRUE;
    self.goodsType3 = TRUE;
    self.goodsType4 = TRUE;
    self.ordertype = @"0";
    self.cityID = @"";
    return self;
}

+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


-(NSString *)stringGoodsType
{
    NSString *str = nil;
    if (self.goodsType1) {
        if (str) {
            str = [NSString stringWithFormat:@"%@,%@",str,@"1"];
        }
        else str = @"1";
    }
    if (self.goodsType2) {
        if (str) {
            str = [NSString stringWithFormat:@"%@,%@",str,@"2"];
        }
        else str = @"2";
    }
    if (self.goodsType3) {
        if (str) {
            str = [NSString stringWithFormat:@"%@,%@",str,@"3"];
        }
        else str = @"3";
    }
    if (self.goodsType4) {
        if (str) {
            str = [NSString stringWithFormat:@"%@,%@",str,@"4"];
        }
        else str = @"4";
    }
    return str;
}
@end
