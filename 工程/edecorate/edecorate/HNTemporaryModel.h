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

typedef NS_ENUM(NSInteger, HNTemporaryType)
{
    FIRE,
    POWER
};

typedef NS_ENUM(NSInteger, HNTemporaryStatus)
{
    TemporaryStatusCustom,
    TemporaryStatusApplying,
    TemporaryStatusPassed,
    TemporaryStatusNotPassed
    
};

@interface HNTemporaryHouseInfoModel : NSObject
@property (nonatomic, strong)NSString *houseInf;
@property (nonatomic, strong)NSString *constructionPerson;
@property (nonatomic, strong)NSString *constructionPersonPhoneNumber;
@property (nonatomic, strong)NSString *owners;
@property (nonatomic, strong)NSString *ownersPhoneNumber;
@property (nonatomic, strong)NSString *constructionUnit;
-(BOOL)updateData:(NSDictionary *)dic;
@end

@interface HNTemporaryFireDataInfoModel : NSObject
@property (nonatomic, strong)NSString *fireUnits;
@property (nonatomic, strong)NSString *useOfFireBy;
@property (nonatomic, strong)NSString *fireTools;
@property (nonatomic, strong)NSString *fireLoad;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *operatorPerson;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *validDocuments;
-(BOOL)updateData:(NSDictionary *)dic;
@end

@interface HNComplaintModel : NSObject
@property (nonatomic, strong)NSString *complaintCategory;
@property (nonatomic, strong)NSString *complaintObject;
@property (nonatomic, strong)NSString *complaintIssue;
-(BOOL)updateData:(NSDictionary *)dic;
@end

@interface HNTemporaryModel : NSObject
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)HNTemporaryHouseInfoModel *huseInfo;
@property (nonatomic)HNTemporaryStatus status;
@property (nonatomic) HNTemporaryType type;
@property (nonatomic) UIImage *image;
@end

@interface HNTemporaryFireModel : HNTemporaryModel
@property (nonatomic, strong)NSString *fireId;
@property (nonatomic, strong)HNTemporaryFireDataInfoModel *dataInfo;
-(BOOL)updateData:(NSDictionary *)dic;
@end


//*******


@interface HNTemporaryElectroDataInfoModel : NSObject
@property (nonatomic, strong)NSString *electroEnterprise;
@property (nonatomic, strong)NSString *electroCause;
@property (nonatomic, strong)NSString *electroTool;
@property (nonatomic, strong)NSString *electroLoad;
@property (nonatomic, strong)NSString *electroBTime;
@property (nonatomic, strong)NSString *electroETime;
@property (nonatomic, strong)NSString *electroOperator;
@property (nonatomic, strong)NSString *electroPhone;
@property (nonatomic, strong)NSString *PapersImg;
-(BOOL)updateData:(NSDictionary *)dic;
@end

@interface HNTemporaryElectroModel : HNTemporaryModel
@property (nonatomic, strong)NSString *electroId;
@property (nonatomic, strong)HNTemporaryElectroDataInfoModel *dataInfo;
-(BOOL)updateData:(NSDictionary *)dic;
@end


@interface HNTemporaryData : NSObject
@property (nonatomic, strong)NSString *mshopid;
@property (nonatomic, strong)NSNumber *total;
@property (nonatomic, strong)NSString *error;
@property (nonatomic, strong)NSMutableArray *modelList;
@property (nonatomic) HNTemporaryType type;
-(BOOL)updateData:(NSDictionary *)dic;
@end

#endif

