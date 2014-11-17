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

+(UIImage *)imageWithLink:(NSString *)link{
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[link addPort]]]];
    return image? image : [UIImage imageNamed:@"selectphoto.png"];
}

+(UIColor *)projectGreen{
    return [UIColor colorWithRed:144.0/255.0 green:197.0/255.0 blue:31.0/255.0 alpha:1.0];
}

+(UIColor *)projectRed{
    return [UIColor colorWithRed:1.0 green:85.0/255.0 blue:0 alpha:1.0];
}

@end
