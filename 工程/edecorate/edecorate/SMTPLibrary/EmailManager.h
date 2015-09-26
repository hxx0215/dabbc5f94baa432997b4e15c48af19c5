//
//  EmailManager.h
//  edecorate
//
//  Created by hxx on 2/4/15.
//
//

#import <Foundation/Foundation.h>

@interface EmailManager : NSObject
+(instancetype)sharedManager;
-(void)send:(NSString *)title content:(NSString *)content;
@end
