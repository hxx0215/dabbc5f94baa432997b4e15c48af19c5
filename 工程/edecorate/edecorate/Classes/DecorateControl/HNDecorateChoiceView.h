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

//{"bank_type":"0","bargainor_id":"1223440601","callback_url":"http://helper.ezxvip.com/pay/decotatePaySucceed_notify.aspx","charset":"1","desc":"为报建项目Id为10119的办出入证缴费","notify_url":"http://helper.ezxvip.com/pay/decotatePaySucceed_notify.aspx","sp_billno":"20141129170836503","total_fee":"0","ver":"2.0","mysign":"7c90cc57096a104a2083c39240d43f0d","privateKey":"ddccfc2704ce209e6cbfc6e0fbf6d3dc"}]
@interface HNDecoratePayModel : NSObject
@property (nonatomic, strong)NSString *bank_type;
@property (nonatomic, strong)NSString *bargainor_id;
@property (nonatomic, strong)NSString *callback_url;
@property (nonatomic, strong)NSString *charset;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *notify_url;
@property (nonatomic, strong)NSString *sp_billno;
@property (nonatomic, strong)NSString *total_fee;
@property (nonatomic, strong)NSString *ver;
@property (nonatomic, strong)NSString *mysign;
@property (nonatomic, strong)NSString *privateKey;
@property (nonatomic, strong)NSString *fee_type;

@property (nonatomic, strong)NSDictionary *dic;
-(NSString *)getToken;
-(void)updataDic:(NSDictionary *)dic;
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
- (void)didGetPayToken:(NSString*)token;
@end

@interface HNDecorateChoiceView : UIView
@property (nonatomic, weak) id <HNDecorateChoiceViewDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *decorateList;
@property (nonatomic)BOOL updataDecorateInformation;
@property (nonatomic, strong)HNDecorateChoiceModel *model;
@property (nonatomic)HNPayType payType;
-(void) getPayToken:(NSString*)connid;
@end
