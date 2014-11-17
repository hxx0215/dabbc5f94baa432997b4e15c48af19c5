//
//  HNDecorateChoiceView.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-29.
//
//

#import <UIKit/UIKit.h>
#import "HNDecorateData.h"

//partner	合作者
//seller	卖家
//out_trade_no	交易订单号
//subject	"为订单" + orderid + "进行付款"
//body	"为订单" + orderid + "进行付款"
//total_fee	总费用
//notify_url	异步通知回调地址
//mysign	生成签名
//privateKey	商户私钥

//业主自装缴费 = 0,公司承包装修缴费 = 1,办出入证缴费 = 2,送货安装缴费 = 3, 板楼加建缴费 = 4
typedef enum _HNPAYTYPE
{
    KHNPayTypeNo = 0,
    KHNPayType0,
    KHNPayType1,
    KHNPayType2,
    KHNPayType3,
    KHNPayType4
}HNPayType;

@interface HNDecoratePayModel : NSObject
@property (nonatomic, strong)NSString *partner;
@property (nonatomic, strong)NSString *seller;
@property (nonatomic, strong)NSString *out_trade_no;
@property (nonatomic, strong)NSString *subject;
@property (nonatomic, strong)NSString *total_fee;
@property (nonatomic, strong)NSString *body;
@property (nonatomic, strong)NSString *notify_url;
@property (nonatomic, strong)NSString *mysign;
@property (nonatomic, strong)NSString *privateKey;
@end

@interface HNDecorateChoiceModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *ownername;
@property (nonatomic, strong)NSString *ownerphone;
@property (nonatomic, strong)HNDecoratePayModel *payModel;
@end


@protocol HNDecorateChoiceViewDelegate <NSObject>
- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model;
@end

@interface HNDecorateChoiceView : UIView
@property (nonatomic, weak) id <HNDecorateChoiceViewDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *decorateList;
@property (nonatomic)BOOL updataDecorateInformation;
@property (nonatomic, strong)HNDecorateChoiceModel *model;
@property (nonatomic)HNPayType payType;
@end
