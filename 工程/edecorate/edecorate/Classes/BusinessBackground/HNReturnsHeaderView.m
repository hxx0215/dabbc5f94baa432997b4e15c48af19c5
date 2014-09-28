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
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-60, 44)];
        self.statusButton = [self createButtonWithTitle:NSLocalizedString(@"All Goods", nil)];
        self.statusButton.frame = CGRectMake(self.search.right,self.search.top,60,self.search.height);
        [self addSubview:self.search];
        [self.statusButton addTarget:self action:@selector(algoods:) forControlEvents:UIControlEventTouchUpInside];
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
