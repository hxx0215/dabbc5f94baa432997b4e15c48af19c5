//
//  HNDeliveApplyTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-1.
//
//

#import "HNDeliveApplyTableViewCell.h"

@interface HNDeliveApplyTableViewCell()<UITextFieldDelegate>

@end

@implementation HNDeliveApplyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameTextField = (UITextField*)[self viewWithTag:1];
    self.phoneTextField = (UITextField*)[self viewWithTag:2];
    self.cardNOTextField = (UITextField*)[self viewWithTag:3];
    self.iconImageView = (UIImageView*)[self viewWithTag:4];
    self.uploadButton = (UIButton*)[self viewWithTag:5];
    
    self.nameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.cardNOTextField.delegate = self;
    
    self.uploadButton.backgroundColor = [UIColor colorWithRed:45/255.0 green:179/255.0 blue:123/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextFieldDelegate:(id<HNDeliveApplyAddNewTableViewCellDelegate>)delegate proposerData:(HNDeliverProposerItem*) proposer
{
    self.delegate = delegate;
    self.proposerData = proposer;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.delegate willDidMoveScrollView:textField];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    [self.delegate didMoveScrollView:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.proposerData.name = self.nameTextField.text;
    self.proposerData.phone = self.phoneTextField.text;
    self.proposerData.IDcard = self.cardNOTextField.text;
    self.proposerData.IDcardImg = @"123";
    self.proposerData.Icon = @"123";
    [self.delegate finishMoveScrollView:textField];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




@end
