//
//  HNOrderHeaderView.m
//  edecorate
//
//  Created by hxx on 9/28/14.
//
//

#import "HNOrderHeaderView.h"
#import "UIView+AHKit.h"

@implementation HNOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor colorWithWhite:245.0/255.0 alpha:1.0];
        self.filter = [self createButtonWithTitle:NSLocalizedString(@"所有分类", nil)];
        [self.filter setTitleColor:[UIColor projectGreen] forState:UIControlStateNormal];
        self.filter.frame = CGRectMake(0, 0, 100, 44);
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 0, frame.size.width - 100, 44)];
        self.search.layer.cornerRadius = 7.0;
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
