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
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* contentLabel;

@property (nonatomic, strong) UIButton* CommentButton;
@property (nonatomic, strong) UIButton* hideButton;
@property (nonatomic, strong) UIButton* deleteButton;

@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) UIButton* textButton;
@end

@implementation HNCommentsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 1, 100, 20)];
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 1, 100, 20)];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    
    self.CommentButton = [self buttonWithTitle:@"回复" selector:@selector(commentClick)];
    self.CommentButton.frame = CGRectMake(self.right-60, 21, 50, 30);
    self.hideButton = [self buttonWithTitle:@"隐藏" selector:@selector(hideClick)];
    self.hideButton.frame = CGRectMake(self.right-115, 21, 50, 30);
    self.deleteButton = [self buttonWithTitle:@"删除" selector:@selector(deleteClick)];
    self.deleteButton.frame = CGRectMake(self.right-170, 21, 50, 30);
    return self;
}

-(void)commentsName:(NSString*)name commentsContent:(NSString*)content
{
    [self labelWithTitle:name label:self.nameLabel];
    [self labelWithTitle:content label:self.contentLabel];
    self.contentLabel.left = self.nameLabel.right;
}

-(UIButton*) buttonWithTitle:(NSString*)title selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    return btn;

}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    
}


-(void)commentClick
{
    if (self.textField) {
        return;
    }
    self.height = 128;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(self.left, 55, self.width-20, 40)];
    [self addSubview:self.textField];
    self.textField.layer.borderWidth = 1.0;
    self.textField.layer.borderColor = [UIColor blackColor].CGColor;
    self.textButton = [self buttonWithTitle:@"回复" selector:@selector(commentDidClick)];
    self.textButton.frame = CGRectMake(self.CommentButton.left, 97, self.CommentButton.width, self.CommentButton.height);
    if([self.delegate respondsToSelector:@selector(CommentsNewWillDid:)]) {
        [self.delegate CommentsNewWillDid:self];
    }
}

-(void)commentDidClick
{
    NSString* str = self.textField.text;
    [self.textField removeFromSuperview];
    [self.textButton removeFromSuperview];
    self.textField = nil;
    self.textButton = nil;
    self.height = 51;
    if([self.delegate respondsToSelector:@selector(CommentsNewDid: contentString:)]) {
        [self.delegate CommentsNewDid:self contentString:str];
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
