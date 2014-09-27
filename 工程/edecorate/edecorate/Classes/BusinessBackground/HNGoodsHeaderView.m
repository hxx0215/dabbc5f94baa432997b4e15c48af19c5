//
//  HNGoodsHeaderView.m
//  edecorate
//
//  Created by hxx on 9/27/14.
//
//

#import "HNGoodsHeaderView.h"
#import "UIView+AHKit.h"
@implementation HNGoodsHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        self.categoryButton = [self createButtonWithTitle:NSLocalizedString(@"All Categories", nil)];
        self.statusButton = [self createButtonWithTitle:NSLocalizedString(@"All Goods", nil)];
        self.categoryButton.top = self.search.bottom;
        self.statusButton.top = self.search.bottom;
        self.statusButton.right = frame.size.width;
        [self addSubview:self.search];
    }
    return self;
}
- (UIButton *)createButtonWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [self addSubview:btn];
    return btn;
}
@end
