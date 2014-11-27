//
//  HNReturnsHeaderView.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-28.
//
//

#import "HNReturnsHeaderView.h"
#import "UIView+AHKit.h"

@implementation HNReturnsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor colorWithWhite:245.0/255.0 alpha:1.0];
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 0, frame.size.width - 100, 44)];
        self.search.layer.cornerRadius = 7.0;
        self.statusButton = [self createButtonWithTitle:NSLocalizedString(@"所有分类", nil)];
        self.statusButton.frame = frame = CGRectMake(0, 0, 100, 44);
        [self addSubview:self.search];
        [self.statusButton addTarget:self action:@selector(algoods:) forControlEvents:UIControlEventTouchUpInside];
        [self.statusButton setTitleColor:[UIColor projectGreen] forState:UIControlStateNormal];
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
- (void)algoods:(id)sender{
    NSLog(@"ALL goods");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
