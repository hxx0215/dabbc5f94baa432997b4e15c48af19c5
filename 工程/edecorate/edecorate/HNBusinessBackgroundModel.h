//
//  HNBusinessBackgroundModel.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//
#ifndef BUSINESSBKMODEL
#define BUSINESSBKMODEL
#import <Foundation/Foundation.h>

@interface HNBusinessBackgroundModel : NSObject
@end

@interface HNBusinessBKProfileModel : NSObject
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* category;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* shopkeeper;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* onlineService;
@end

@interface HNLocation : NSObject

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end


#endif
