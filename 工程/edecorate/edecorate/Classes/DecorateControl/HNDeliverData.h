//
//  HNDeliverData.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-10.
//
//

#import <Foundation/Foundation.h>

@interface HNDeliverData : NSObject
@property (nonatomic, strong)NSString *shopname;
@property (nonatomic, strong)NSString *roomnumber;
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *installId;//暂定
@property (nonatomic, strong)NSString *ownername;//
@property (nonatomic, strong)NSString *ownerphone;//
@property (nonatomic, strong)NSString *proposerItem;
@property (nonatomic, strong)NSString *principal;
@property (nonatomic, strong)NSString *EnterprisePhone;
@property (nonatomic, strong)NSString *needItem;//
@property (nonatomic, strong)NSString *manageItem;
@property (nonatomic, strong)NSString *product;
@property (nonatomic, strong)NSString *bTime;
@property (nonatomic, strong)NSString *eTime;
@property (nonatomic, strong)NSString *state;
-(BOOL)updateData:(NSDictionary *)dic;
@end
