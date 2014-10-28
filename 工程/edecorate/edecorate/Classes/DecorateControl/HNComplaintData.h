//
//  HNComplaintData.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-25.
//
//

#import <Foundation/Foundation.h>

/*
 room	报建信息
 complainId	Id
 complainObject	投诉对象
 complainProblem	投诉问题
 complainType	投诉类别
 body	投诉内容
 CreateTime	投诉时间
 constructionTeam	业主回复
 management	施工方回复
 */
@interface HNComplaintData : NSObject
@property (nonatomic, strong)NSString *shopname;
@property (nonatomic, strong)NSString *room;
@property (nonatomic, strong)NSString *complainId;
@property (nonatomic, strong)NSString *complainObject;//
@property (nonatomic, strong)NSString *complainProblem;//
@property (nonatomic, strong)NSString *complainType;//
@property (nonatomic, strong)NSString *body;//
@property (nonatomic, strong)NSString *CreateTime;
@property (nonatomic, strong)NSString *constructionTeam;
@property (nonatomic, strong)NSString *management;

-(BOOL)updateData:(NSDictionary *)dic;
@end

