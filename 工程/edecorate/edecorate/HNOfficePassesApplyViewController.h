//
//  HNOfficePassesApplyViewController.h
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import <UIKit/UIKit.h>
#import "HNTemporaryModel.h"

@interface HNOfficePassesApplyViewController : UIViewController
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
-(id)initWithModel:(HNTemporaryModel *)model;
@end
