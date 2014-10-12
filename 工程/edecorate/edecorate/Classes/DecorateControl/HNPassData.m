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
    
    self.proposerItems = [[NSMutableArray alloc] init];
    NSArray* array = [dic objectForKey:@"proposerItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNPassProposerData *tModel = [[HNPassProposerData alloc] init];
        [tModel updateData:dicData];
        [self.proposerItems addObject:tModel];
    }
    
    [self setValue:[dic objectForKey:@"principal"] forKey:@"principal"];
    [self setValue:[dic objectForKey:@"EnterprisePhone"] forKey:@"EnterprisePhone"];
    [self setValue:[dic objectForKey:@"population"] forKey:@"population"];
    
    self.needItems = [[NSMutableArray alloc] init];
    array = [dic objectForKey:@"needItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNPassNeedItem *tModel = [[HNPassNeedItem alloc] init];
        [tModel updateData:dicData];
        [self.needItems addObject:tModel];
    }
    
    self.manageItems = [[NSMutableArray alloc] init];
    array = [dic objectForKey:@"manageItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNPassManageItem *tModel = [[HNPassManageItem alloc] init];
        [tModel updateData:dicData];
        [self.manageItems addObject:tModel];
    }
    return YES;
}
@end

@implementation HNPassProposerData
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    [self setValue:[dic objectForKey:@"sad"] forKey:@"sad"];
    [self setValue:[dic objectForKey:@"phone"] forKey:@"phone"];
    [self setValue:[dic objectForKey:@"IDcard"] forKey:@"IDcard"];
    [self setValue:[dic objectForKey:@"IDcardImg"] forKey:@"IDcardImg"];
    [self setValue:[dic objectForKey:@"Icon"] forKey:@"Icon"];
    [self setValue:[dic objectForKey:@"isTransaction"] forKey:@"isTransaction"];
    return YES;
}
@end

@implementation HNPassNeedItem
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    [self setValue:[dic objectForKey:@"sad"] forKey:@"price"];
    [self setValue:[dic objectForKey:@"phone"] forKey:@"numer"];
    [self setValue:[dic objectForKey:@"IDcard"] forKey:@"totalMoney"];
    [self setValue:[dic objectForKey:@"IDcardImg"] forKey:@"useUnit"];
    return YES;
}
@end


@implementation HNPassManageItem
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    [self setValue:[dic objectForKey:@"sad"] forKey:@"price"];
    [self setValue:[dic objectForKey:@"phone"] forKey:@"userUnit"];
    [self setValue:[dic objectForKey:@"IDcard"] forKey:@"explain"];
    [self setValue:[dic objectForKey:@"IDcardImg"] forKey:@"IsSubmit"];
    [self setValue:[dic objectForKey:@"Icon"] forKey:@"Isrefund"];
    [self setValue:[dic objectForKey:@"isTransaction"] forKey:@"sort"];
    return YES;
}
@end
