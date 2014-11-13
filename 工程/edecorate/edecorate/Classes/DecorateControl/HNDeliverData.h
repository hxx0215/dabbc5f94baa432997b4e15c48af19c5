//
//  HNDeliverData.h
//  edecorate
//
//  Created by 刘向宏 on 14-10-10.
//
//

#import <Foundation/Foundation.h>

@interface HNDeliverData : NSObject
@property (nonatomic, strong)NSString *shopname;
@property (nonatomic, strong)NSString *roomnumber;
@property (nonatomic, strong)NSString *declareId;
@property (nonatomic, strong)NSString *installId;//暂定
@property (nonatomic, strong)NSString *ownername;//
@property (nonatomic, strong)NSString *ownerphone;//
@property (nonatomic, strong)NSMutableArray *proposerItems;
@property (nonatomic, strong)NSString *principal;
@property (nonatomic, strong)NSString *EnterprisePhone;
@property (nonatomic, strong)NSMutableArray *needItems;//
@property (nonatomic, strong)NSMutableArray *manageItems;
@property (nonatomic, strong)NSString *product;
@property (nonatomic, strong)NSString *bTime;
@property (nonatomic, strong)NSString *eTime;
@property (nonatomic, strong)NSString *state;
-(BOOL)updateData:(NSDictionary *)dic;
@end

//办证人员信息JSON（name：姓名，phone：联系电话，IDcard：身份证号，IDcardImg：身份证照片，Icon:图像）
@interface HNDeliverProposerItem : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;//
@property (nonatomic, strong)NSString *IDcard;
@property (nonatomic, strong)NSString *IDcardImg;
@property (nonatomic, strong)NSString *Icon;

@property (nonatomic, strong)UIImage *imageIDcard;
@property (nonatomic, strong)UIImage *imageIcon;
-(BOOL)updateData:(NSDictionary *)dic;
@end


//"查看详情已选择的缴费JSON【详情查看】
//（name：缴费项名称，price:缴费金额，numer：数量，totalMoney：总金额，useUnit：单位）"
@interface HNDeliverNeedItem : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *numer;//
@property (nonatomic, strong)NSString *totalMoney;
@property (nonatomic, strong)NSString *useUnit;
-(BOOL)updateData:(NSDictionary *)dic;
@end

//"送货安装缴费配置项json  【申请时选择】
//(name:名称，price:单价，userUnit:单位，explain:说明，IsSubmit:是否必交，Isrefund:是否可退，sort:排序)"
@interface HNDeliverManageItem : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *userUnit;//
@property (nonatomic, strong)NSString *explain;
@property (nonatomic, strong)NSString *IsSubmit;
@property (nonatomic, strong)NSString *Isrefund;//
@property (nonatomic, strong)NSString *sort;
-(BOOL)updateData:(NSDictionary *)dic;
@end
