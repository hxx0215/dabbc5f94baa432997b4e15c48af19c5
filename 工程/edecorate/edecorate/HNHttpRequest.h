//
//  HNHttpRequest.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-15.
//
//

#import <Foundation/Foundation.h>


@interface HNHttpRequest : NSObject

+(id)upload:(NSString *)url widthParams:(NSDictionary *)params;

@end

@interface FileDetail : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSData *data;
+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data;
@end