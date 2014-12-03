//
//  HNFilterModel.h
//  edecorate
//
//  Created by 刘向宏 on 14-12-2.
//
//

#import <Foundation/Foundation.h>

@interface HNFilterModel : NSObject
+(instancetype)shared;
-(NSString *)stringGoodsType;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *cityID;
@property (nonatomic, strong)NSString *ordertype;
@property (nonatomic) BOOL goodsType1;
@property (nonatomic) BOOL goodsType2;
@property (nonatomic) BOOL goodsType3;
@property (nonatomic) BOOL goodsType4;
@end
