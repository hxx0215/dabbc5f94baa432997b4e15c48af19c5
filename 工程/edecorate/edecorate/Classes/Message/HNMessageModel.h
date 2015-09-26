//
//  HNMessageModel.h
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import <Foundation/Foundation.h>
/*
 mid	ID
 fromid	来源  0 系统邮件
 title	标题
 message	内容
 isread	是否已读
 mtype	1公告 0消息
 addtime	添加时间
 */

@interface HNMessageModel : NSObject
@property (nonatomic, strong)NSString *mid;
@property (nonatomic, strong)NSString *fromid;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *message;
@property (nonatomic, strong)NSString *isread;
@property (nonatomic, strong)NSString *mtype;
@property (nonatomic, strong)NSString *addtime;
-(BOOL)updateData:(NSDictionary *)dic;
@end
