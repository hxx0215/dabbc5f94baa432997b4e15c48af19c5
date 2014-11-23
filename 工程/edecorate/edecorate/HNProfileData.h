//
//  HNProfileData.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-22.
//
//

#import <Foundation/Foundation.h>

@interface HNProfileData : NSObject
@property (nonatomic, strong)NSString *attorneyIDcard;
@property (nonatomic, strong)NSString *createtime;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *idcard;
@property (nonatomic, strong)NSString *lastlogintime;
@property (nonatomic, strong)NSString *mshopid;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *shopusername;
-(BOOL)updateData:(NSDictionary *)dic;
@end
