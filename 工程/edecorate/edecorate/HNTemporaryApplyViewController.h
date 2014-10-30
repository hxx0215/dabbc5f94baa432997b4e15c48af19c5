//
//  HNTemporaryApplyViewController.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import <UIKit/UIKit.h>
#include "HNTemporaryModel.h"
@interface HNTemporaryApplyViewController : UIViewController
@property (nonatomic, strong)HNTemporaryModel* temporaryModel;
-(id)initWithType:(HNTemporaryType)type;
@end
