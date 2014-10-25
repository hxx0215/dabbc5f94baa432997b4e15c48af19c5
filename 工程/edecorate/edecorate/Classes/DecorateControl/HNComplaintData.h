//
//  HNComplaintData.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-25.
//
//

#import <Foundation/Foundation.h>

@interface HNComplaintData : NSObject
//@property (nonatomic, strong)NSString *shopname;
//@property (nonatomic, strong)NSString *roomnumber;
//@property (nonatomic, strong)NSString *declareId;
//@property (nonatomic, strong)NSString *CARDId;//
//@property (nonatomic, strong)NSString *ownername;//
//@property (nonatomic, strong)NSString *ownerphone;//
//@property (nonatomic, strong)NSString *assessorState;//
//@property (nonatomic, strong)NSString *principal;
//@property (nonatomic, strong)NSString *EnterprisePhone;
//@property (nonatomic, strong)NSString *population;

//@property (nonatomic, strong)NSMutableArray *projectrefundBody;
//@property (nonatomic, strong)NSMutableArray *finefundBody;
//@property (nonatomic, strong)NSString *projectrefund;
//@property (nonatomic, strong)NSString *finefund;
//@property (nonatomic, strong)NSString *cardnumber;
-(BOOL)updateData:(NSDictionary *)dic;
@end


////[{count:编号，money:金额，name:退款项}] 可退款
//@interface HNPassNeedItem : NSObject
//@property (nonatomic, strong)NSString *name;
//@property (nonatomic, strong)NSString *price;
//@property (nonatomic, strong)NSString *numer;//
//@property (nonatomic, strong)NSString *totalMoney;
//@property (nonatomic, strong)NSString *useUnit;
//-(BOOL)updateData:(NSDictionary *)dic;
//@end
//
////[{count:编号，money:金额，name:原因}] 处罚
//@interface HNPassManageItem : NSObject
//@property (nonatomic, strong)NSString *name;
//@property (nonatomic, strong)NSString *price;
//@property (nonatomic, strong)NSString *userUnit;//
//@property (nonatomic, strong)NSString *explain;
//@property (nonatomic, strong)NSString *IsSubmit;
//@property (nonatomic, strong)NSString *Isrefund;//
//@property (nonatomic, strong)NSString *sort;
//-(BOOL)updateData:(NSDictionary *)dic;
//@end