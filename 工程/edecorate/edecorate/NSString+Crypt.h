//
//  NSString+Crypt.h
//  edecorate
//
//  Created by hxx on 10/3/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Crypt)
+ (NSString *)encodeToPercentEscapeString:(NSString *)input;
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
- (NSString *)encryptWithDES;
- (NSString *)decryptWithDES;
- (NSString *) stringFromMD5;
+ (NSString *)createSignWithMethod:(NSString *)method Params:(NSString *)params;
+ (NSString *)createResponseURLWithMethod:(NSString *)method Params:(NSString *)params;
+ (NSString *)createLongResponseURLWithMethod:(NSString *)method Params:(NSString *)params;
- (NSString *)addPort;
@end


@interface UIColor (Project)
+ (UIColor *)projectGreen;
+ (UIColor *)projectRed;
@end