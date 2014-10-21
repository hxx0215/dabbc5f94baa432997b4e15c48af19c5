//
//  HNLoginView.m
//  edecorate
//
//  Created by hxx on 10/21/14.
//
//

#import "HNLoginView.h"
@interface HNLoginView()
@property (nonatomic, strong)UILabel *userLabel;
@property (nonatomic, strong)UILabel *passwordLabel;
@end
@implementation HNLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0;
        self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, frame.size.height / 2 -1)];
        self.userLabel.text = NSLocalizedString(@"User", nil);
        self.userLabel.textAlignment = NSTextAlignmentRight;
        self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userLabel.height + 2, 85, frame.size.height / 2)];
        self.passwordLabel.text = NSLocalizedString(@"Password", nil);
        self.passwordLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.userLabel];
        [self addSubview:self.passwordLabel];
    }
    return self;
}

@end
