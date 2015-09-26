//
//  HNUpgrade.m
//  edecorate
//
//  Created by hxx on 12/9/14.
//
//

#import "HNUpgrade.h"
@interface HNUpgrade()
@property (nonatomic, strong)NSArray *versions;

@end
@implementation HNUpgrade
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static HNUpgrade * sharedInstance;
    dispatch_once(&once, ^ { sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}
- (void)checkUpdate:(void (^)(BOOL flag))haveUpgrade{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.versions = [app_Version componentsSeparatedByString:@"."];
    //NSDictionary *sendDic = @{@"type":[NSString stringWithFormat:@"%d",1]};
    NSString *sendJson = @"{\"type\":1}";//[sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.mobile.version" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (count !=0 ){
                NSDictionary *data = retDic[@"data"][0];
                NSString *versions = data[@"version"];
                self.upgradeUrl = data[@"url"];
                NSArray *version = [versions componentsSeparatedByString:@"."];
                BOOL flag = NO;
                for (int i=0;i<MIN([version count], [self.versions count]);i++)
                {
                    NSInteger now = [self.versions[i] integerValue];
                    NSInteger up = [version[i] integerValue];
                    if (up>now){
                        flag = YES;
                    }
                }
                haveUpgrade(flag);
            }
            haveUpgrade(NO);
        }else
            haveUpgrade(NO);
    }];
}
- (void)upgrade{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.upgradeUrl]];
}
@end
