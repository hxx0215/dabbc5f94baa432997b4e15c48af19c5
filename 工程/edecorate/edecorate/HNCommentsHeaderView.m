//
//  HNCommentsHeaderView.m
//  edecorate
//
//  Created by 熊彬 on 14-9-28.
//
//

#import "HNCommentsHeaderView.h"
#import "UIView+AHKit.h"
#import "HNCommentsTableViewCell.h"



@implementation HNCommentsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 115, 75)];
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blueColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.grouppriceLabel = [[UILabel alloc]init];
        self.grouppriceLabel.textColor = [UIColor redColor];
        self.grouppriceLabel.font = [UIFont systemFontOfSize:13];
        self.stockLabel = [[UILabel alloc]init];
        self.stockLabel.font = [UIFont systemFontOfSize:13];
        
        self.grouppriceTLabel = [[UILabel alloc]init];
        self.grouppriceTLabel.font = [UIFont systemFontOfSize:13];
        self.grouppriceTLabel.frame = CGRectMake(130, 35, self.width-130, 15);
        self.grouppriceTLabel.text = @"销售价格：";
        [self.grouppriceTLabel sizeToFit];
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.grouppriceLabel];
        [self addSubview:self.grouppriceTLabel];
        [self addSubview:self.stockLabel];
      
    }
    return self;
}

-(void)layoutSubviews
{
    self.titleLabel.frame = CGRectMake(130, 15, self.width-130, 15);
    self.grouppriceLabel.frame = CGRectMake(self.grouppriceTLabel.right, 35, self.width-130, 15);
    self.stockLabel.frame = CGRectMake(130, 55, self.width-130, 15);
}

- (void)setContent:(NSDictionary *)content
{
    self.titleLabel.text = [content objectForKey:@"goodsname"];
    self.grouppriceLabel.text = [content objectForKey:@"groupprice"];
    self.stockLabel.text = [NSString stringWithFormat:@"库存：%@",[content objectForKey:@"stock"]] ;
}

@end
