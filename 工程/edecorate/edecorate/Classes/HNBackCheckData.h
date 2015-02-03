//
//  HNBackCheckData.h
//  edecorate
//
//  Created by hxx on 2/3/15.
//
//

#import <Foundation/Foundation.h>

@interface HNBackCheckData : NSObject
+(instancetype)shared;
-(void)send:(id)message;
@end
