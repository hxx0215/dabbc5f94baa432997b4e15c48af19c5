//
//  HNDecorateChoiceView.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-29.
//
//

#import <UIKit/UIKit.h>
#import "HNDecorateData.h"
#import "HNPaySupport.h"


@interface HNDecorateChoiceModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *processstep;
@property (nonatomic, strong)NSString *paystate;
@property (nonatomic, strong)NSString *assessorstate;
@property (nonatomic, strong)NSString *createTime;
@property (nonatomic, strong)NSDictionary *alldata;

@property (nonatomic, strong)NSString *ownername;
@property (nonatomic, strong)NSString *ownerphone;
@property (nonatomic, strong)HNPaySupport *payModel;
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
