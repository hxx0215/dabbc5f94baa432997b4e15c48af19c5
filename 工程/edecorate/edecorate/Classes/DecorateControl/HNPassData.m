//
//  HNPassData.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-11.
//
//

#import "HNPassData.h"

@implementation HNPassData
-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"shopname"] forKey:@"shopname"];
    [self setValue:[dic objectForKey:@"roomnumber"] forKey:@"roomnumber"];
    [self setValue:[dic objectForKey:@"declareId"] forKey:@"declareId"];
    [self setValue:[dic objectForKey:@"CARDId"] forKey:@"CARDId"];
    [self setValue:[dic objectForKey:@"ownername"] forKey:@"ownername"];
    [self setValue:[dic objectForKey:@"ownerphone"] forKey:@"ownerphone"];
    [self setValue:[dic objectForKey:@"assessorState"] forKey:@"assessorState"];
    //[self setValue:[dic objectForKey:@"proposerItem"] forKey:@"proposerItem"];
    [self setValue:[dic objectForKey:@"principal"] forKey:@"principal"];
    [self setValue:[dic objectForKey:@"EnterprisePhone"] forKey:@"EnterprisePhone"];
    [self setValue:[dic objectForKey:@"population"] forKey:@"population"];
    //[self setValue:[dic objectForKey:@"needItem"] forKey:@"needItem"];
    //[self setValue:[dic objectForKey:@"manageItem"] forKey:@"manageItem"];
    return YES;
}
@end
