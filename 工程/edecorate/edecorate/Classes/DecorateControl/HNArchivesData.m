//
//  HNArchivesData.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-14.
//
//

#import "HNArchivesData.h"
/*
fileid	档案项目编号
title	标题
satisfaction	是否满意
isReturn	是否回复（回复了 不能再回复）
CreateTime	提出问题的时间
 */
@implementation HNArchivesData
-(BOOL)updateData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"fileid"] forKey:@"fileid"];
    [self setValue:[dic objectForKey:@"title"] forKey:@"title"];
    [self setValue:[dic objectForKey:@"satisfaction"] forKey:@"satisfaction"];
    [self setValue:[dic objectForKey:@"isReturn"] forKey:@"isReturn"];
    [self setValue:[dic objectForKey:@"CreateTime"] forKey:@"CreateTime"];
    return true;
}


-(BOOL)updateDeteilData:(NSDictionary *)dic
{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"declareId"] forKey:@"declareId"];
    [self setValue:[dic objectForKey:@"EnterpriseFile"] forKey:@"EnterpriseFile"];
    [self setValue:[dic objectForKey:@"gccReturn"] forKey:@"gccReturn"];
    [self setValue:[dic objectForKey:@"gccReturnTime"] forKey:@"gccReturnTime"];
    [self setValue:[dic objectForKey:@"ownerFile"] forKey:@"ownerFile"];
    [self setValue:[dic objectForKey:@"ownerRemark"] forKey:@"ownerRemark"];
    return true;
}

@end
