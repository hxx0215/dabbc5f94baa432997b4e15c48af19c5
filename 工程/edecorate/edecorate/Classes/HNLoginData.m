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
@end
