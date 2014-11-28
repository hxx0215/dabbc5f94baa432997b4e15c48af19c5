//
//  HNLoginData.m
//  edecorate
//
//  Created by hxx on 10/6/14.
//
//

#import "HNLoginData.h"

@implementation HNLoginData
+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"uid"] forKey:@"uid"];
    [self setValue:[dic objectForKey:@"username"] forKey:@"username"];
    [self setValue:[dic objectForKey:@"realname"] forKey:@"realname"];
    [self setValue:[dic objectForKey:@"idcard"] forKey:@"idcard"];
    [self setValue:[dic objectForKey:@"mshopid"] forKey:@"mshopid"];
    [self setValue:[dic objectForKey:@"email"] forKey:@"email"];
    [self setValue:[dic objectForKey:@"lastlogintime"] forKey:@"lastlogintime"];
    [self setValue:[dic objectForKey:@"msg"] forKey:@"msg"];
    [self setValue:[dic objectForKey:@"state"] forKey:@"state"];
    return YES;
}
- (NSString *)mapOrderStatusID:(NSString *)statusID{
    /*订单状态[买家已退货= -14, 同意换货= -13,同意退货= -12,
     已完成报修= -11,申请报修= -10,已换货= -9,申请换货中= -8,商家取消= -7,已退货= -6,申请退货中= -5,已退款= -4,申请退款= -3,管理员取消= -2,用户取消= -1, 未处理= 0,已付款= 1, 等待发货= 2, 已发货= 3, 已确认收货= 4,已完成= 5])
     */
    NSDictionary *map =
    @{@"-14": NSLocalizedString(@"买家已退货", nil) ,
      @"-13" :NSLocalizedString(@"同意换货", nil) ,
      @"-12" : NSLocalizedString(@"同意退货", nil) ,
      @"-11" : NSLocalizedString(@"已完成报修", nil),
      @"-10" : NSLocalizedString(@"申请报修", nil),
      @"-9" : NSLocalizedString(@"已换货", nil) ,
      @"-8" : NSLocalizedString(@"申请换货中", nil),
      @"-7" : NSLocalizedString(@"商家取消", nil),
      @"-6" : NSLocalizedString(@"已退货", nil),
      @"-5" : NSLocalizedString(@"申请退货中", nil),
      @"-4" : NSLocalizedString(@"已退款", nil),
      @"-3" : NSLocalizedString(@"申请退款", nil),
      @"-2" : NSLocalizedString(@"管理员取消", nil),
      @"-1" : NSLocalizedString(@"用户取消", nil),
      @"0" : NSLocalizedString(@"待付款", nil),
      @"1" : NSLocalizedString(@"已付款", nil),
      @"2" : NSLocalizedString(@"等待发货", nil),
      @"3" : NSLocalizedString(@"已发货", nil),
      @"4" : NSLocalizedString(@"已确认收货", nil),
      @"5" : NSLocalizedString(@"已完成", nil)};
    return map[statusID];
}
@end
