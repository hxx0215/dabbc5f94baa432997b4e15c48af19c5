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
        self.backgroundColor = [UIColor colorWithWhite:245.0/255.0 alpha:1.0];
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 0, frame.size.width - 100, 44)];
        self.search.layer.cornerRadius = 7.0;
        self.categoryButton = [self createButtonWithTitle:NSLocalizedString(@"所有分类", nil)];
        self.categoryButton.frame = CGRectMake(0, 0, 100, 44);
        [self.categoryButton setTitleColor:[UIColor projectGreen] forState:UIControlStateNormal];
//        self.statusButton = [self createButtonWithTitle:NSLocalizedString(@"All Goods", nil)];
//        self.statusButton.top = self.search.bottom;
//        self.statusButton.right = frame.size.width;
        [self addSubview:self.search];
//        [self.statusButton addTarget:self action:@selector(algoods:) forControlEvents:UIControlEventTouchUpInside];
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
