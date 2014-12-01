//
//  HNPurchaseItem.h
//  edecorate
//
//  Created by hxx on 10/24/14.
//
//

#import <Foundation/Foundation.h>

@interface HNPurchaseItem : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)CGFloat price;
@property (nonatomic, assign)NSInteger single;
@property (nonatomic, assign)NSInteger nums;
@property (nonatomic, assign)CGFloat unitPrice;
@property (nonatomic, assign)BOOL isSelect;
@end
