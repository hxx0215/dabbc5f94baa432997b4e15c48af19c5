//
//  HNUpgrade.h
//  edecorate
//
//  Created by hxx on 12/9/14.
//
//

#import <Foundation/Foundation.h>

@interface HNUpgrade : NSObject
+(instancetype)sharedInstance;
- (void)checkUpdate:(void (^)(BOOL flag))haveUpgrade;
- (void)upgrade;
@property (nonatomic, copy)NSString *upgradeUrl;
@end
