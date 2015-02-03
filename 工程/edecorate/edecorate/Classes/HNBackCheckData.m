//
//  HNBackCheckData.m
//  edecorate
//
//  Created by hxx on 2/3/15.
//
//

#import "HNBackCheckData.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
@interface HNBackCheckData()
@property (nonatomic, retain)SKPSMTPMessage *emailConfig;
@end
@implementation HNBackCheckData
+(instancetype)shared{
    static dispatch_once_t once;
    static HNBackCheckData * checkData;
    dispatch_once(&once, ^ {
        checkData = [[HNBackCheckData alloc] init];
        checkData.emailConfig = [[SKPSMTPMessage alloc] init];
        checkData.emailConfig.fromEmail = @"edecoratesend@126.com";
        
        checkData.emailConfig.toEmail = @"edecorate@126.com";
        testMsg.bccEmail = [defaults objectForKey:@"bccEmal"];
        testMsg.relayHost = [defaults objectForKey:@"relayHost"];
        
        testMsg.requiresAuth = [[defaults objectForKey:@"requiresAuth"] boolValue];
        
        if (testMsg.requiresAuth) {
            testMsg.login = [defaults objectForKey:@"login"];
            
            testMsg.pass = [defaults objectForKey:@"pass"];
            
        }
        
        testMsg.wantsSecure = [[defaults objectForKey:@"wantsSecure"] boolValue]; // smtp.gmail.com doesn't work without TLS!
        
        
        testMsg.subject = @"SMTPMessage Test Message";
        //testMsg.bccEmail = @"testbcc@test.com";
        
        // Only do this for self-signed certs!
        // testMsg.validateSSLChain = NO;
        testMsg.delegate = self;
    });
    return checkData;
}
-(void)send:(id)message{
    
}
@end
