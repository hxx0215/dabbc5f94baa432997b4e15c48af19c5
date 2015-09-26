//
//  HNDeliverDetailViewController.h
//  edecorate
//
//  Created by hxx on 9/22/14.
//
//

#import <UIKit/UIKit.h>
#import "HNDeliverData.h"

@interface HNDeliverDetailViewController : UIViewController
@property (nonatomic, strong)HNDeliverData* deliverModel;
-(id)initWithModel:(HNDeliverData *)model;
@end
