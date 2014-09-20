//
//  HNCheckDetailView.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNCheckDetailView.h"
#import "UIView+AHKit.h"

@interface HNCheckDetailView()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)NSMutableArray *items;
@end
@implementation HNCheckDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items width:(CGFloat)width{
    self = [super init];
    if (self){
        self.width = width;
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = title;
        [self.titleLabel sizeToFit];
        [self addSubview:self.titleLabel];
        self.items = [items mutableCopy];
        self.buttons = [[NSMutableArray alloc] init];
        [self initItems];
        self.height = ((UIButton *)[self.buttons lastObject]).bottom;
    }
    return self;
}

- (void)initItems{
    __block CGFloat top = self.titleLabel.bottom;
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UILabel *label = [[UILabel alloc] init];
        label.top = top;
        label.text = obj;
        [label sizeToFit];
        top = label.bottom + 10;
        [self addSubview:label];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1.0;
        [btn sizeToFit];
        btn.height = label.height;
        btn.width *= 2;
        btn.right = self.width - 20;
        btn.top = label.top;
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }];
}
- (void)setSelector:(SEL)selector{
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop){
        UIButton *btn = obj;
        [btn addTarget:self.controller action:selector forControlEvents:UIControlEventTouchUpInside];
    }];
}
- (void)setButtonTag:(NSInteger)base{
    self.base = base;
    for (int i=0;i< [self.buttons count];i++)
        ((UIButton *)self.buttons[i]).tag = base+i;
}
@end
