//
//  HNCommentsHeaderView.h
//  edecorate
//
//  Created by 熊彬 on 14-9-28.
//
//

#import <UIKit/UIKit.h>

@interface HNCommentsHeaderView : UIView
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *grouppriceTLabel;
@property (nonatomic, strong)UILabel *grouppriceLabel;
@property (nonatomic, strong)UILabel *stockLabel;
- (void)setContent:(NSDictionary *)content;
@end
