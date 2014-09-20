//
//  HNTemporaryModel.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNTemporaryModel.h"

@implementation HNHouseInfoModel
-(id)init
{
    self = [super init];

    self.houseInf = @"深圳南三区么么大厦1层23楼";
    self.constructionPerson = @"李大木";
    self.owners = @"李大木";
    self.ownersPhoneNumber = @"13560731432";
    self.constructionPersonPhoneNumber = @"13560731432";
    self.constructionUnit = @"深圳装修公司";
    return self;
}
@end

@implementation HNTemporaryModel
-(id)init
{
    self = [super init];
    self.huseInfo = [[HNHouseInfoModel alloc] init];
    return self;
}
@end
