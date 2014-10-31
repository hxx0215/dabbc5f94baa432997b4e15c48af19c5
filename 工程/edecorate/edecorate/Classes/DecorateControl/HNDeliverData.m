//
//  HNDeliverData.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-10.
//
//

#import "HNDeliverData.h"

@implementation HNDeliverData
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
    
    
    NSArray* array = [dic objectForKey:@"proposerItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNDeliverProposerItem *tModel = [[HNDeliverProposerItem alloc] init];
        [tModel updateData:dicData];
        [self.proposerItems addObject:tModel];
    }
    
    
    array = [dic objectForKey:@"needItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNDeliverNeedItem *tModel = [[HNDeliverNeedItem alloc] init];
        [tModel updateData:dicData];
        [self.needItems addObject:tModel];
    }
    
    
    array = [dic objectForKey:@"manageItem"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNDeliverManageItem *tModel = [[HNDeliverManageItem alloc] init];
        [tModel updateData:dicData];
        [self.manageItems addObject:tModel];
    }

    return YES;
}
@end

@implementation HNDeliverProposerItem
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    [self setValue:[dic objectForKey:@"phone"] forKey:@"phone"];
    [self setValue:[dic objectForKey:@"IDcard"] forKey:@"IDcard"];
    [self setValue:[dic objectForKey:@"IDcardImg"] forKey:@"IDcardImg"];
    [self setValue:[dic objectForKey:@"Icon"] forKey:@"Icon"];
    return YES;
}
@end

@implementation HNDeliverNeedItem
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


@implementation HNDeliverManageItem
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
