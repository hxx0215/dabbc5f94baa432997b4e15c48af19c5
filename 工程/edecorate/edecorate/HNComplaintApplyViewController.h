//
//  HNComplaintApplyViewController.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import <UIKit/UIKit.h>
#import "HNTemporaryModel.h"

@interface HNComplaintApplyViewController : UIViewController
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
-(id)initWithModel:(HNTemporaryModel *)model;
@end
