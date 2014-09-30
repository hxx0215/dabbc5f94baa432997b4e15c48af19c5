//
//  HNBusinessBackgroundModel.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNBusinessBackgroundModel.h"

@implementation HNBusinessBKReturnsModel
-(id)init
{
    self = [super init];
    self.returnsType = kReturnGood;
    return self;
}
@end

@implementation HNBusinessBackgroundModel
-(id)init
{
    self = [super init];
    return self;
}
@end

@implementation HNBusinessBKProfileModel

-(id)init
{
    self = [super init];
    self.name = @"黑木崖";
    self.category = @"服务";
    self.address = @"华尔街1090号";
    self.shopkeeper = @"李大木";
    self.phone = @"13590000000";
    self.onlineService = @"78789890";
    return self;
}

@end

@implementation HNLocation
@synthesize country = _country;
@synthesize state = _state;
@synthesize city = _city;
@synthesize district = _district;
@synthesize street = _street;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

@end