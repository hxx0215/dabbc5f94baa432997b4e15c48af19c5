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
@property (nonatomic, strong) NSString *room;
@property (nonatomic, strong) NSString *fileid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *satisfaction;
@property (nonatomic, strong) NSString *isReturn;
@property (nonatomic, strong) NSString *CreateTime;

@property (nonatomic, strong) NSString *declareId;
@property (nonatomic, strong) NSString *EnterpriseFile;
@property (nonatomic, strong) NSString *gccReturn;
@property (nonatomic, strong) NSString *gccReturnTime;
@property (nonatomic, strong) NSString *ownerFile;
@property (nonatomic, strong) NSString *ownerRemark;
-(BOOL)updateData:(NSDictionary *)dic;

/*
fileId	档案项目编号
title	标题
satisfaction	是否满意
declareId	装修项目Id
CreateTime	提出问题的时间
EnterpriseFile	施工方回复附件
gccReturn	施工方回复内容
gccReturnTime	回复时间
ownerFile	业主上传的附件
ownerRemark	业主提交的内容
*/
-(BOOL)updateDeteilData:(NSDictionary *)dic;
@end
