//
//  EmailManager.m
//  edecorate
//
//  Created by hxx on 2/4/15.
//
//

#import "EmailManager.h"
#import "SKPSMTPMessage.h"
@interface EmailManager()<SKPSMTPMessageDelegate>
@property (nonatomic, strong)SKPSMTPMessage *message;
@end
@implementation EmailManager

+ (instancetype)sharedManager {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}
-(void)initMessage{
    SKPSMTPMessage *msg = [[SKPSMTPMessage alloc] init];
    msg.fromEmail = @"edecoratesend@126.com";
    msg.toEmail = @"edecorate@126.com";
    msg.relayHost = @"smtp.126.com";
    msg.requiresAuth = YES;
    msg.login = @"edecoratesend@126.com";
    msg.pass = @"922033";
    msg.wantsSecure = YES;
    msg.delegate = self;
}
-(void)send:(NSString *)title content:(NSString *)content{
    SKPSMTPMessage *msg = [[SKPSMTPMessage alloc] init];
    msg.fromEmail = @"edecoratesend@126.com";
    msg.toEmail = @"edecorate@126.com";
    msg.relayHost = @"smtp.126.com";
    msg.requiresAuth = YES;
    msg.login = @"edecoratesend@126.com";
    msg.pass = @"922033";
    msg.wantsSecure = YES;
    msg.delegate = self;
    msg.subject = title;
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain; charset=UTF-8",kSKPSMTPPartContentTypeKey,
                               content,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    msg.parts = @[plainPart];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [msg send];
    });
    
}
-(void)messageSent:(SKPSMTPMessage *)message{
    
}
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    
}
@end
