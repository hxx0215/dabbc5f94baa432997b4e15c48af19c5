//
//  HNTemporaryModel.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//
#ifndef TEMPORARYMODEL
#define TEMPORARYMODEL
#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, HNTemporaryStatus)
{
    TemporaryStatusCustom,
    TemporaryStatusApplying,
    TemporaryStatusPassed,
    TemporaryStatusNotPassed
    
};

@interface HNTemporaryModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic)HNTemporaryStatus status;

@property (nonatomic, strong)NSString *houseInf;
@property (nonatomic, strong)NSString *constructionPerson;
@property (nonatomic, strong)NSString *constructionPersonPhoneNumber;
@property (nonatomic, strong)NSString *owners;
@property (nonatomic, strong)NSString *ownersPhoneNumber;
@property (nonatomic, strong)NSString *constructionUnit;
@end
#endif
