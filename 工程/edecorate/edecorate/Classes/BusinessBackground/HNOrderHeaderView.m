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
        self.filter = [self createButtonWithTitle:NSLocalizedString(@"All Order", nil)];
        self.filter.right = frame.size.width;
        self.filter.centerY = frame.size.height / 2;
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - self.filter.width - 10 , 44)];
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
