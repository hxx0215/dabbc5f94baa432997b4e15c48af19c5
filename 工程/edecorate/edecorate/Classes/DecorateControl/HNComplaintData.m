//
//  HNComplaintData.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-25.
//
//

#import "HNComplaintData.h"

@implementation HNComplaintData
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"room"] forKey:@"room"];
    [self setValue:[dic objectForKey:@"complainId"] forKey:@"complainId"];
    [self setValue:[dic objectForKey:@"complainObject"] forKey:@"complainObject"];
    [self setValue:[dic objectForKey:@"complainProblem"] forKey:@"complainProblem"];
    [self setValue:[dic objectForKey:@"complainType"] forKey:@"complainType"];
    [self setValue:[dic objectForKey:@"body"] forKey:@"body"];
    [self setValue:[dic objectForKey:@"CreateTime"] forKey:@"CreateTime"];
    [self setValue:[dic objectForKey:@"constructionTeam"] forKey:@"constructionTeam"];
    [self setValue:[dic objectForKey:@"management"] forKey:@"management"];
    return YES;
}
@end