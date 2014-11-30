//
//  HNProfileData.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-22.
//
//

#import "HNProfileData.h"
/*attorneyIDcard	施工负责人身份证照片
createtime	注册时间
email	电子邮箱
idcard	施工负责人身份证
lastlogintime	上次登录时间
mshopid	商家Id
phone	电话
realname	真实姓名
shopusername	登录名
 */
@implementation HNProfileData
-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"headImage"] forKey:@"headImage"];
    [self setValue:[dic objectForKey:@"attorneyIDcard"] forKey:@"attorneyIDcard"];
    [self setValue:[dic objectForKey:@"createtime"] forKey:@"createtime"];
    [self setValue:[dic objectForKey:@"email"] forKey:@"email"];
    [self setValue:[dic objectForKey:@"idcard"] forKey:@"idcard"];
    [self setValue:[dic objectForKey:@"mshopid"] forKey:@"mshopid"];
    [self setValue:[dic objectForKey:@"lastlogintime"] forKey:@"lastlogintime"];
    [self setValue:[dic objectForKey:@"phone"] forKey:@"phone"];
    [self setValue:[dic objectForKey:@"realname"] forKey:@"realname"];
    [self setValue:[dic objectForKey:@"shopusername"] forKey:@"shopusername"];
    return YES;
}
@end
