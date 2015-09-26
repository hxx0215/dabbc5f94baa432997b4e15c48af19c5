//
//  HNRefundData.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-25.
//
//

#import "HNRefundData.h"

@implementation HNRefundModel
@end

@implementation HNRefundData
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    self.projectrefundBody = [[NSMutableArray alloc] init];
    NSArray* array = [dic objectForKey:@"projectrefundBody"];
    for (int i=0; i<[array count]; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        HNRefundBodyItem *tModel = [[HNRefundBodyItem alloc] init];
        [tModel updateData:dicData];
        [self.projectrefundBody addObject:tModel];
    }
    
    self.finefundBody = [[NSMutableArray alloc] init];
    NSArray* array2 = [dic objectForKey:@"finefundBody"];
    for (int i=0; i<[array2 count]; i++) {
        NSDictionary *dicData = [array2 objectAtIndex:i];
        HNRefundBodyItem *tModel = [[HNRefundBodyItem alloc] init];
        [tModel updateData:dicData];
        [self.finefundBody addObject:tModel];
    }
    [self setValue:[dic objectForKey:@"projectrefund"] forKey:@"projectrefund"];
    [self setValue:[dic objectForKey:@"finefund"] forKey:@"finefund"];
    [self setValue:[dic objectForKey:@"cardnumber"] forKey:@"cardnumber"];
    return YES;
}
@end

@implementation HNRefundBodyItem
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"count"] forKey:@"count"];
    [self setValue:[dic objectForKey:@"money"] forKey:@"money"];
    [self setValue:[dic objectForKey:@"name"] forKey:@"name"];
    return YES;
}
@end