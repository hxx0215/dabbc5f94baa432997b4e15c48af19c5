//
//  HNUIStyleSet.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-6.
//
//

#import "HNUIStyleSet.h"

@implementation HNUIStyleSet
+(void)UIStyleSetRoundView:(UIView*)label
{
    label.layer.cornerRadius = 7;
    label.layer.borderWidth = 0;
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.masksToBounds = YES;
}
@end
