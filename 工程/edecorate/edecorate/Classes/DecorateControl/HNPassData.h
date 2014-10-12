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
@property (nonatomic, strong)NSString *proposerItem;
@property (nonatomic, strong)NSString *principal;
@property (nonatomic, strong)NSString *EnterprisePhone;
@property (nonatomic, strong)NSString *population;
@property (nonatomic, strong)NSString *needItem;//
@property (nonatomic, strong)NSString *manageItem;
-(BOOL)updateData:(NSDictionary *)dic;
@end