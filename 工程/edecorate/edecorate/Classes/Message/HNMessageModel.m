//
//  HNMessageModel.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNMessageModel.h"

@implementation HNMessageModel
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"mid"] forKey:@"mid"];
    [self setValue:[dic objectForKey:@"fromid"] forKey:@"fromid"];
    [self setValue:[dic objectForKey:@"title"] forKey:@"title"];
    [self setValue:[dic objectForKey:@"message"] forKey:@"message"];
    [self setValue:[dic objectForKey:@"isread"] forKey:@"isread"];
    [self setValue:[dic objectForKey:@"mtype"] forKey:@"mtype"];
    [self setValue:[dic objectForKey:@"addtime"] forKey:@"addtime"];
    return YES;
}
@end
