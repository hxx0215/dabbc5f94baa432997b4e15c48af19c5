//
//  HNArchivesData.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-14.
//
//

#import <Foundation/Foundation.h>

/*
 fileid	档案项目编号
 title	标题
 satisfaction	是否满意
 isReturn	是否回复（回复了 不能再回复）
 CreateTime	提出问题的时间
 */

@interface HNArchivesData : NSObject
@property (nonatomic, strong) NSString *fileid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *satisfaction;
@property (nonatomic, strong) NSString *isReturn;
@property (nonatomic, strong) NSString *CreateTime;
-(BOOL)updateData:(NSDictionary *)dic;
@end
