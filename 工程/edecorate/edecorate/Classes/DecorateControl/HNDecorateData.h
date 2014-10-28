//
//  HNDecorateData.h
//  edecorate
//
//  Created by hxx on 10/28/14.
//
//

#import <Foundation/Foundation.h>

@interface HNDecorateData : NSObject
+(instancetype)shared;
-(void)loadingDecorateData:(NSString *)mshopid block:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))loadComplete;
-(void)loadingDecorateData:(NSString *)mshopid pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize block:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))loadComplete;

- (void)loadingDetail:(NSString *)mshopid declare:(NSString *)declareId block:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError))loadComplete;
@end
