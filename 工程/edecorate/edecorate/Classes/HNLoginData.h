//
//  HNLoginData.h
//  edecorate
//
//  Created by hxx on 10/6/14.
//
//

#import <Foundation/Foundation.h>

@interface HNLoginData : NSObject
+(instancetype)shared;
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *icon;//暂定
@property (nonatomic, strong)NSString *funds;//
@property (nonatomic, strong)NSString *integral;//
@property (nonatomic, strong)NSString *mshopid;
@property (nonatomic, strong)NSString *lastlogintime;
@property (nonatomic, strong)NSString *msg;
@property (nonatomic, strong)NSString *status;//
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *idcard;
-(BOOL)updateData:(NSDictionary *)dic;
@end
//注意，此处单例并不是严格的按照单例方式实现可以自行创建其他实例，本项目中只有这么几个人就算了..
