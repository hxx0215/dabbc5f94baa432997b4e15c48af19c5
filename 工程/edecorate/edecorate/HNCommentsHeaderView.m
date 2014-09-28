//
//  HNCommentsHeaderView.m
//  edecorate
//
//  Created by 熊彬 on 14-9-28.
//
//

#import "HNCommentsHeaderView.h"
#import "UIView+AHKit.h"



@implementation HNCommentsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"评论",@"留言",nil];
        self.segment= [[UISegmentedControl alloc]initWithItems:segmentedArray];
        self.segment.frame = CGRectMake(50, 5, frame.size.width-100, 30);
        self.segment.selectedSegmentIndex = 0;//设置默认选择项索引
        self.segment.tintColor = [UIColor greenColor];
        self.segment.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
        
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 35, frame.size.width, 44)];
        //self.search = [[UISearchBar alloc] init];  self.segment.size.height
        //self.search.top=self.segment.bottom;
        //self.segment.top=self.search.bottom;
        [self addSubview:self.segment];
        [self addSubview:self.search];
      
    }
    return self;
}

@end
