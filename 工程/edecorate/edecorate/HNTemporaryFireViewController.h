//
//  HNTemporaryFireViewController.h
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HNTemporaryType)
{
    FIRE,
    POWER
};

@interface HNTemporaryFireViewController : UIViewController
-(id)initWithTemporaryType:(HNTemporaryType)type;
@end
