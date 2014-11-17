//
//  HNImageData.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-17.
//
//

#import <Foundation/Foundation.h>

@interface HNImageData : NSObject
+(instancetype)shared;
-(UIImage *)imageWithLink:(NSString *)link;
@end
