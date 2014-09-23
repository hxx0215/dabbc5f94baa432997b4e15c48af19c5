//
//  HNOfficePassesDetailsViewController.h
//  edecorate
//
//  Created by 熊彬 on 14-9-21.
//
//

#import <UIKit/UIKit.h>
#import "HNTemporaryModel.h"

@interface HNOfficePassesDetailsViewController : UIViewController
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
-(id)initWithModel:(HNTemporaryModel *)model;
@end
