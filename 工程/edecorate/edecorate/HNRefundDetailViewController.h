//
//  HNRefundDetailViewController.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import <UIKit/UIKit.h>
#import "HNRefundData.h"

@interface HNRefundDetailViewController : UIViewController
@property (nonatomic, strong)HNRefundData* temporaryModel;
-(id)initWithModel:(HNRefundData *)model;
@end
