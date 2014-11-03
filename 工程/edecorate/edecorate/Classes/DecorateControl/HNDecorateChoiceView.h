//
//  HNDecorateChoiceView.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-29.
//
//

#import <UIKit/UIKit.h>
#import "HNDecorateData.h"

@interface HNDecorateChoiceModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *ownername;
@property (nonatomic, strong)NSString *ownerphone;

@end


@protocol HNDecorateChoiceViewDelegate <NSObject>
- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model;
@end

@interface HNDecorateChoiceView : UIView
@property (nonatomic, weak) id <HNDecorateChoiceViewDelegate> delegate;
@property (nonatomic, strong)NSMutableArray *decorateList;
@property (nonatomic)BOOL updataDecorateInformation;
@end
