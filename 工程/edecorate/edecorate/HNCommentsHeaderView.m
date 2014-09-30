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
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"评论",@"留言",nil];
        self.segment= [[UISegmentedControl alloc]initWithItems:segmentedArray];
        self.segment.frame = CGRectMake(50, 5, frame.size.width-100, 30);
        self.segment.selectedSegmentIndex = 0;//设置默认选择项索引
        self.segment.tintColor = [UIColor greenColor];   
        self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 35, frame.size.width, 44)];
        [self.segment addTarget:self action:@selector(segmentClick:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.segment];
        [self addSubview:self.search];
        //调用HNCommentsTableViewCell.h的SetTableByType方法，默认设置table为评论的列表
      //  HNCommentsTableViewCell *table=[[HNCommentsTableViewCell alloc] init];
        //[table SetTableByType:0];
      
    }
    return self;
}

- (void)segmentClick:(id)sender {
    
    NSInteger Index = self.segment.selectedSegmentIndex;
    switch (Index)
    {
        case 0:
//            HNCommentsTableViewCell *table=[[HNCommentsTableViewCell alloc] init];
//            [table SetTableByType:0];
            break;
        case 1:
//            HNCommentsTableViewCell *table=[[HNCommentsTableViewCell alloc] init];
//            [table SetTableByType:1];
            break;
        default:
            break;
    }
}

@end
