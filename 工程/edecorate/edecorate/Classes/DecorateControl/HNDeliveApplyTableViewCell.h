//
//  HNDeliveApplyTableViewCell.h
//  edecorate
//
//  Created by 刘向宏 on 14-11-1.
//
//

#import <UIKit/UIKit.h>
#import "HNDeliverData.h"

@interface HNDeliveApplyTableViewCell : UITableViewCell
-(void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate proposerData:(HNDeliverProposerItem*) proposer;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *cardNOTextField;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) HNDeliverProposerItem* proposerData;
@property (nonatomic, strong) id <UITextFieldDelegate> delegate;
@end
