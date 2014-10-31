//
//  HNDeliveApplyTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-1.
//
//

#import "HNDeliveApplyTableViewCell.h"

@implementation HNDeliveApplyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameTextField = (UITextField*)[self viewWithTag:1];
    self.phoneTextField = (UITextField*)[self viewWithTag:2];
    self.cardNOTextField = (UITextField*)[self viewWithTag:3];
    self.iconImageView = (UIImageView*)[self viewWithTag:4];
    self.uploadButton = (UIButton*)[self viewWithTag:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate proposerData:(HNDeliverProposerItem*) proposer
{
    self.nameTextField.delegate = self.delegate;
    self.phoneTextField.delegate = self.delegate;
    self.cardNOTextField.delegate = self.delegate;
    
    self.proposerData = proposer;
}

@end
