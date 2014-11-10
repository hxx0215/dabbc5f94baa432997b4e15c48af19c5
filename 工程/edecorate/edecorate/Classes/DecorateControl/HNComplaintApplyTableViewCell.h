//
//  HNComplaintApplyTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-9.
//
//

#import <UIKit/UIKit.h>

@interface HNComplaintApplyTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton *photo;
@property (nonatomic, strong)UITextField *textView;
@property (nonatomic, strong)UITextView *textView2;
@property (nonatomic, strong)UILabel *title;
- (void)setStyle:(NSInteger)flage;
@end
