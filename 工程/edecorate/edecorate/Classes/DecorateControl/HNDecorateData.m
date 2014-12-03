//
//  HNDecorateData.m
//  edecorate
//
//  Created by hxx on 10/28/14.
//
//

#import "HNDecorateData.h"

@implementation HNDecorateData
+ (instancetype)shared {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)loadingDecorateData:(NSString *)mshopid block:(void (^)(NSURLResponse *, NSData *, NSError *))loadComplete{
    [self loadingDecorateData:mshopid pageIndex:0 pageSize:10000 block:loadComplete];
}

-(void)loadingDecorateData:(NSString *)mshopid pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize block:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))loadComplete{
    assert(mshopid != nil);
    assert(loadComplete != nil);
    NSMutableDictionary *sendDic = [[NSMutableDictionary alloc] init];
    [sendDic setObject:mshopid forKey:@"mshopid"];
    if (pageIndex > 0)
        [sendDic setObject:[NSNumber numberWithInteger:pageIndex] forKey:@"pageindex"];
    if (pageSize > 0)
        [sendDic setObject:[NSNumber numberWithInteger:pageSize] forKey:@"pagesize"];
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.decoration.declare" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        loadComplete(response,data,connectionError);
    }];
}

- (void)loadingDetail:(NSString *)mshopid declare:(NSString *)declareId block:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))loadComplete{
    assert(mshopid != nil);
    assert(loadComplete != nil);
    assert(declareId != nil);
    NSMutableDictionary *sendDic = [[NSMutableDictionary alloc] init];
    [sendDic setObject:mshopid forKey:@"mshopid"];
    [sendDic setObject:declareId forKey:@"declareid"];
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.decoraton.declaredetails" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        loadComplete(response,data,connectionError);
    }];
}
@end
