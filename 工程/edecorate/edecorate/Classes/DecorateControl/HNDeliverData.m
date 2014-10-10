//
//  HNDeliverData.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-10.
//
//

#import "HNDeliverData.h"

@implementation HNDeliverData
-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"shopname"] forKey:@"shopname"];
    [self setValue:[dic objectForKey:@"roomnumber"] forKey:@"roomnumber"];
    [self setValue:[dic objectForKey:@"declareId"] forKey:@"declareId"];
    [self setValue:[dic objectForKey:@"installId"] forKey:@"installId"];
    [self setValue:[dic objectForKey:@"ownername"] forKey:@"ownername"];
    [self setValue:[dic objectForKey:@"ownerphone"] forKey:@"ownerphone"];
    //[self setValue:[dic objectForKey:@"proposerItem"] forKey:@"proposerItem"];
    [self setValue:[dic objectForKey:@"principal"] forKey:@"principal"];
    [self setValue:[dic objectForKey:@"EnterprisePhone"] forKey:@"EnterprisePhone"];
    //[self setValue:[dic objectForKey:@"needItem"] forKey:@"needItem"];
    //[self setValue:[dic objectForKey:@"manageItem"] forKey:@"manageItem"];
    [self setValue:[dic objectForKey:@"product"] forKey:@"product"];
    [self setValue:[dic objectForKey:@"bTime"] forKey:@"bTime"];
    [self setValue:[dic objectForKey:@"eTime"] forKey:@"eTime"];
    [self setValue:[dic objectForKey:@"state"] forKey:@"state"];
    return YES;
}
@end
