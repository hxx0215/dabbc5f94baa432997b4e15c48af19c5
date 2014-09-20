//
//  HNTemporaryDetailsViewController.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import <UIKit/UIKit.h>
#include "HNTemporaryModel.h"

@interface HNTemporaryDetailsViewController : UIViewController
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
-(id)initWithModel:(HNTemporaryModel *)model;
@end
