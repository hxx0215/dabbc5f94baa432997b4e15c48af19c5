//
//  HNRefundData.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-25.
//
//

#import <Foundation/Foundation.h>

//[{count:编号，money:金额，name:退款项}] 可退款
//[{count:编号，money:金额，name:原因}] 处罚
@interface HNRefundBodyItem : NSObject
@property (nonatomic, strong)NSString *count;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *name;
-(BOOL)updateData:(NSDictionary *)dic;
@end

@interface HNRefundData : NSObject
@property (nonatomic, strong)NSMutableArray *projectrefundBody;
@property (nonatomic, strong)NSMutableArray *finefundBody;
@property (nonatomic, strong)NSString *projectrefund;
@property (nonatomic, strong)NSString *finefund;
@property (nonatomic, strong)NSString *cardnumber;
-(BOOL)updateData:(NSDictionary *)dic;
@end


