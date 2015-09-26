//
//  HNPaySupport.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-30.
//
//

#import <Foundation/Foundation.h>

//办出入证缴费 = 2,送货安装缴费 = 3, 板楼加建缴费 = 4，业主自装施工方缴费 = 5,公司承包装修施工方缴费 = 6, 板楼加建施工方缴费 = 7
typedef enum _HNPAYTYPE
{
    KHNPayTypeNo = 0,
    KHNPayTypePass = 2,
    KHNPayTypeDeliver = 3,
    KHNPayType4 = 4,
    KHNPayType5 = 5,
    KHNPayType6 = 6,
    KHNPayType7 = 7
}HNPayType;

@protocol HNDecoratePayModelDelegate <NSObject>
- (void)didGetPayUrl:(NSString*)url;
@end

@interface HNPaySupport : NSObject
+(instancetype)shared;
@property (nonatomic, weak) id <HNDecoratePayModelDelegate> delegate;
//cid:类型为4 5 6 7的传报建项目编号， 2传出入证Id，3传送货安装Id
-(void) getPayToken:(NSString *)declareId cid:(NSString*)connid payType:(HNPayType)type;
@end