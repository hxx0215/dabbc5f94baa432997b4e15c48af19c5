//
//  HNOfficePassesDetailsViewController.h
//  edecorate
//
//  Created by 熊彬 on 14-9-21.
//
//

#import <UIKit/UIKit.h>
#import "HNPassData.h"

@interface HNOfficePassesDetailsViewController : UIViewController
@property (nonatomic, strong)HNPassData* temporaryModel;
-(id)initWithModel:(HNPassData *)model;
@end
