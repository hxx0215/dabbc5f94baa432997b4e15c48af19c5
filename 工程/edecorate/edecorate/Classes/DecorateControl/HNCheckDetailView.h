//
//  HNCheckDetailView.h
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import <UIKit/UIKit.h>

@interface HNCheckDetailView : UIView
@property (nonatomic, weak) id controller;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, assign) NSInteger base;
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items width:(CGFloat)width;
- (void)setSelector:(SEL)selector;
- (void)setButtonTag:(NSInteger)base;
@end
