//
//  HNComplaintDetailsViewController.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import <UIKit/UIKit.h>
#include "HNComplaintData.h"

@interface HNComplaintDetailsViewController : UIViewController
@property (nonatomic, strong)HNComplaintData* temporaryModel;
-(id)initWithModel:(HNComplaintData *)model;
@end
