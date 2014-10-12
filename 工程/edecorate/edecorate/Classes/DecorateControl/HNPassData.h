//
//  HNPassData.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-11.
//
//

#import <Foundation/Foundation.h>

@interface HNPassData : NSObject
@property (nonatomic, strong)NSString *shopname;
@property (nonatomic, strong)NSString *roomnumber;
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *CARDId;//
@property (nonatomic, strong)NSString *ownername;//
@property (nonatomic, strong)NSString *ownerphone;//
@property (nonatomic, strong)NSString *assessorState;//
@property (nonatomic, strong)NSMutableArray *proposerItems;
@property (nonatomic, strong)NSString *principal;
@property (nonatomic, strong)NSString *EnterprisePhone;
@property (nonatomic, strong)NSString *population;
@property (nonatomic, strong)NSMutableArray *needItems;//
@property (nonatomic, strong)NSMutableArray *manageItems;
-(BOOL)updateData:(NSDictionary *)dic;
@end

@interface HNProposerData : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *sad;
@property (nonatomic, strong)NSString *phone;//
@property (nonatomic, strong)NSString *IDcard;
@property (nonatomic, strong)NSString *IDcardImg;
@property (nonatomic, strong)NSString *Icon;//
@property (nonatomic, strong)NSString *isTransaction;
-(BOOL)updateData:(NSDictionary *)dic;
@end


//"出入证缴费项详情JSON【已申请的详情项】
//（name：缴费项名称，price:缴费金额，numer：数量，totalMoney：总金额，useUnit：单位）"
@interface HNNeedItem : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *numer;//
@property (nonatomic, strong)NSString *totalMoney;
@property (nonatomic, strong)NSString *useUnit;
-(BOOL)updateData:(NSDictionary *)dic;
@end

//"出入证缴费项json  【申请时选择】
//(name:名称，price:单价，userUnit:单位，explain:说明，IsSubmit:是否必交，Isrefund:是否可退，sort:排序)"
@interface HNManageItem : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *userUnit;//
@property (nonatomic, strong)NSString *explain;
@property (nonatomic, strong)NSString *IsSubmit;
@property (nonatomic, strong)NSString *Isrefund;//
@property (nonatomic, strong)NSString *sort;
-(BOOL)updateData:(NSDictionary *)dic;
@end