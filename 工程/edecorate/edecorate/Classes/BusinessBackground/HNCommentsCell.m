//
//  HNCommentsCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-29.
//
//

#import "HNCommentsCell.h"
#include "UIView+AHKit.h"

@interface HNCommentsCell()
@property (nonatomic, strong) UIButton* CommentButton;
@property (nonatomic, strong) UIButton* hideButton;
@property (nonatomic, strong) UIButton* deleteButton;
@end

@implementation HNCommentsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.CommentButton = [self buttonWithTitle:@"回复" selector:@selector(commentClick)];
    self.hideButton = [self buttonWithTitle:@"隐藏" selector:@selector(hideClick)];
    self.deleteButton = [self buttonWithTitle:@"删除" selector:@selector(deleteClick)];
    return self;
}

-(UIButton*) buttonWithTitle:(NSString*)title selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

    return btn;

}
-(void)commentClick
{
    if([self.delegate respondsToSelector:@selector(CommentsNewDid:)]) {
        [self.delegate CommentsNewDid:self];
    }
}

-(void)hideClick
{
    if([self.delegate respondsToSelector:@selector(CommentsHideDid:)]) {
        [self.delegate CommentsHideDid:self];
    }
}

-(void)deleteClick
{
    if([self.delegate respondsToSelector:@selector(CommentsDeleteDid:)]) {
        [self.delegate CommentsDeleteDid:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
