//
//  HNTemporaryModel.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNTemporaryModel.h"

@implementation HNTemporaryHouseInfoModel
-(id)init
{
    self = [super init];

//    self.houseInf = @"深圳南三区么么大厦1层23楼";
//    self.constructionPerson = @"李大木";
//    self.owners = @"李大木";
//    self.ownersPhoneNumber = @"13560731432";
//    self.constructionPersonPhoneNumber = @"13560731432";
//    self.constructionUnit = @"深圳装修公司";
    return self;
}

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"roomnumber"] forKey:@"houseInf"];
    [self setValue:[dic objectForKey:@"shopname"] forKey:@"constructionUnit"];
    [self setValue:[dic objectForKey:@"ownername"] forKey:@"owners"];
    [self setValue:[dic objectForKey:@"ownerphone"] forKey:@"ownersPhoneNumber"];
    [self setValue:[dic objectForKey:@"EnterprisePhone"] forKey:@"constructionPersonPhoneNumber"];
    [self setValue:[dic objectForKey:@"principal"] forKey:@"constructionPerson"];
    return YES;
}
@end

@implementation HNTemporaryFireDataInfoModel
-(id)init
{
    self = [super init];
    
    self.fireUnits = @"";
    self.useOfFireBy = @"";
    self.fireTools = @"";
    self.fireLoad = @"";
    self.startTime = @"";
    self.endTime = @"";
    self.operatorPerson = @"";
    self.phone = @"";
    self.validDocuments = @"";
    
    return self;
}

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    
    [self setValue:[dic objectForKey:@"fireEnterprise"] forKey:@"fireUnits"];
    [self setValue:[dic objectForKey:@"fireCause"] forKey:@"useOfFireBy"];
    [self setValue:[dic objectForKey:@"fireTool"] forKey:@"fireTools"];
    [self setValue:[dic objectForKey:@"fireLoad"] forKey:@"fireLoad"];
    [self setValue:[dic objectForKey:@"fireBTime"] forKey:@"startTime"];
    [self setValue:[dic objectForKey:@"fireETime"] forKey:@"endTime"];
    [self setValue:[dic objectForKey:@"fireOperator"] forKey:@"operatorPerson"];
    [self setValue:[dic objectForKey:@"firePhone"] forKey:@"phone"];
    [self setValue:[dic objectForKey:@"PapersImg"] forKey:@"validDocuments"];
    return YES;
}
@end

@implementation HNComplaintModel
-(id)init
{
    self = [super init];
    self.complaintCategory = @"";
    self.complaintIssue = @"";
    self.complaintObject = @"";

    return self;
}

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    return YES;
}
@end

@implementation HNTemporaryModel
-(id)init
{
    self = [super init];
    self.huseInfo = [[HNTemporaryHouseInfoModel alloc] init];
    self.dataInfo = [[HNTemporaryFireDataInfoModel alloc] init];
    
    return self;
}
-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"fireId"] forKey:@"fireId"];
    [self setValue:[dic objectForKey:@"declareId"] forKey:@"declareId"];
    self.roomName = [dic objectForKey:@"roomnumber"];
    NSNumber* number = [dic objectForKey:@"IsCheck"];
    switch (number.intValue) {
        case 0:
            self.status = TemporaryStatusApplying;
            break;
        case 1:
            self.status = TemporaryStatusPassed;
            break;
            
        default:
            break;
    }
    if ([self.fireId isEqualToString:@"7"]) {
        self.status = TemporaryStatusCustom;
    }
    [self.huseInfo updateData:dic];
    [self.dataInfo updateData:dic];
    return YES;
}
@end



//*********

@implementation HNTemporaryElectroDataInfoModel

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    
    [self setValue:[dic objectForKey:@"electroEnterprise"] forKey:@"electroEnterprise"];
    [self setValue:[dic objectForKey:@"electroCause"] forKey:@"electroCause"];
    [self setValue:[dic objectForKey:@"electroTool"] forKey:@"electroTool"];
    [self setValue:[dic objectForKey:@"electroLoad"] forKey:@"electroLoad"];
    [self setValue:[dic objectForKey:@"electroBTime"] forKey:@"electroBTime"];
    [self setValue:[dic objectForKey:@"electroETime"] forKey:@"electroETime"];
    [self setValue:[dic objectForKey:@"electroOperator"] forKey:@"electroOperator"];
    [self setValue:[dic objectForKey:@"electroPhone"] forKey:@"electroPhone"];
    [self setValue:[dic objectForKey:@"PapersImg"] forKey:@"PapersImg"];
    return YES;
}
@end

@implementation HNTemporaryElectroModel
-(id)init
{
    self = [super init];
    self.huseInfo = [[HNTemporaryHouseInfoModel alloc] init];
    self.dataInfo = [[HNTemporaryElectroDataInfoModel alloc] init];
    
    return self;
}
-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    [self setValue:[dic objectForKey:@"electroId"] forKey:@"electroId"];
    [self setValue:[dic objectForKey:@"declareId"] forKey:@"declareId"];
    self.roomName = [dic objectForKey:@"roomnumber"];
    NSNumber* number = [dic objectForKey:@"IsCheck"];
    switch (number.intValue) {
        case 0:
            self.status = TemporaryStatusApplying;
            break;
        case 1:
            self.status = TemporaryStatusPassed;
            break;
            
        default:
            break;
    }
    if ([self.electroId isEqualToString:@""]) {
        self.status = TemporaryStatusCustom;
    }
    [self.huseInfo updateData:dic];
    [self.dataInfo updateData:dic];
    return YES;
}
@end


@implementation HNTemporaryData

-(BOOL)updateData:(NSDictionary *)dic{
    if (!dic)
        return NO;
    //[self setValue:[dic objectForKey:@"verification"] forKey:@"verification"];
    [self setValue:[dic objectForKey:@"total"] forKey:@"total"];
    self.modelList = [[NSMutableArray alloc] init];
    NSArray* array = [dic objectForKey:@"data"];
    for (int i = 0; i<self.total.intValue; i++) {
        NSDictionary *dicData = [array objectAtIndex:i];
        switch (self.type) {
            case POWER:
            {
                HNTemporaryElectroModel *tModel = [[HNTemporaryElectroModel alloc] init];
                [tModel updateData:dicData];
                [self.modelList addObject:tModel];
            }
                break;
                
            case FIRE:
            {
                HNTemporaryModel *tModel = [[HNTemporaryModel alloc] init];
                [tModel updateData:dicData];
                [self.modelList addObject:tModel];
            }
                break;
            default:
                break;
        }
        
    }
    
    
    [self setValue:[dic objectForKey:@"error"] forKey:@"error"];
    return YES;
}
@end

