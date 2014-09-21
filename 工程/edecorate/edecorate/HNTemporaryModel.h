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

@interface HNHouseInfoModel : NSObject
@property (nonatomic, strong)NSString *houseInf;
@property (nonatomic, strong)NSString *constructionPerson;
@property (nonatomic, strong)NSString *constructionPersonPhoneNumber;
@property (nonatomic, strong)NSString *owners;
@property (nonatomic, strong)NSString *ownersPhoneNumber;
@property (nonatomic, strong)NSString *constructionUnit;
@end

@interface HNDataInfoModel : NSObject
@property (nonatomic, strong)NSString *fireUnits;
@property (nonatomic, strong)NSString *useOfFireBy;
@property (nonatomic, strong)NSString *fireTools;
@property (nonatomic, strong)NSString *fireLoad;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *operatorPerson;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *validDocuments;
@end

@interface HNComplaintModel : NSObject
@property (nonatomic, strong)NSString *complaintCategory;
@property (nonatomic, strong)NSString *complaintObject;
@property (nonatomic, strong)NSString *complaintIssue;
@end

@interface HNTemporaryModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)HNHouseInfoModel *huseInfo;
@property (nonatomic, strong)HNDataInfoModel *dataInfo;
@property (nonatomic, strong)HNComplaintModel *complaintInfo;
@property (nonatomic)HNTemporaryStatus status;
@end

#endif

