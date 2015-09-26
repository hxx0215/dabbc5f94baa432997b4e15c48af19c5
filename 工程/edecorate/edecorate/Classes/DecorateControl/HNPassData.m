//
//  HNPassData.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-11.
//
//

#import "HNPassData.h"

@implementation HNPassData
-(id)init
{
    self = [super init];
    
    self.proposerItems = [[NSMutableArray alloc] init];
    self.needItems = [[NSMutableArray alloc] init];
    self.manageItems = [[NSMutableArray alloc] init];
    return self;
}

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self.proposerItems removeAllObjects];
    [self.needItems removeAllObjects];
    [self.manageItems removeAllObjects];
    
    [self setValue:[dic objectForKey:@"shopname"] forKey:@"shopname"];
    [self setValue:[dic objectForKey:@"roomnumber"] forKey:@"roomnumber"];
    [self setValue:[dic objectForKey:@"declareId"] forKey:@"declareId"];
    [self setValue:[dic objectForKey:@"CARDId"] forKey:@"CARDId"];
    [self setValue:[dic objectForKey:@"ownername"] forKey:@"ownername"];
    [self setValue:[dic objectForKey:@"ownerphone"] forKey:@"ownerphone"];
    [self setValue:[dic objectForKey:@"assessorState"] forKey:@"assessorState"];
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
    
    
    array = [dic objectForKey:@"needItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNPassNeedItem *tModel = [[HNPassNeedItem alloc] init];
        [tModel updateData:dicData];
        [self.needItems addObject:tModel];
    }
    
    
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
    [self setValue:[dic objectForKey:@"price"] forKey:@"price"];
    [self setValue:[dic objectForKey:@"number"] forKey:@"number"];
    [self setValue:[dic objectForKey:@"totalMoney"] forKey:@"totalMoney"];
    [self setValue:[dic objectForKey:@"useUnit"] forKey:@"useUnit"];
    [self setValue:[dic objectForKey:@"explain"] forKey:@"explain"];
    [self setValue:[dic objectForKey:@"IsSubmit"] forKey:@"IsSubmit"];
    [self setValue:[dic objectForKey:@"Isrefund"] forKey:@"Isrefund"];
    
    return YES;
}
@end


@implementation HNPassManageItem
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    [self setValue:[dic objectForKey:@"price"] forKey:@"price"];
    [self setValue:[dic objectForKey:@"userUnit"] forKey:@"userUnit"];
    [self setValue:[dic objectForKey:@"explain"] forKey:@"explain"];
    [self setValue:[dic objectForKey:@"IsSubmit"] forKey:@"IsSubmit"];
    [self setValue:[dic objectForKey:@"Isrefund"] forKey:@"Isrefund"];
    [self setValue:[dic objectForKey:@"sort"] forKey:@"sort"];
    return YES;
}
@end
