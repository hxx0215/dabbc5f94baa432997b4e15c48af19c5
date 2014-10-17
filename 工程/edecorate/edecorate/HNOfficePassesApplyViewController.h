//
//  HNOfficePassesApplyViewController.h
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import <UIKit/UIKit.h>
#import "HNPassData.h"

@interface HNOfficePassesApplyViewController : UIViewController
@property (nonatomic, strong)HNPassData* temporaryModel;
-(id)initWithModel:(HNPassData *)model;
@end
