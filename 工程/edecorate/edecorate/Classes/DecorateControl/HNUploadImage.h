//
//  HNUploadImage.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-2.
//
//

#import <Foundation/Foundation.h>

@interface HNUploadImage : NSObject
+(void)UploadImage:(UIImage*)image block:(void (^)(NSString *msg))loadComplete;
@end
