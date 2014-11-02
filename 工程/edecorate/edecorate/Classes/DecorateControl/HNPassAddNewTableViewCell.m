//
//  HNPassAddNewTableViewCell.m
//  edecorate
//
//  Created by 刘向宏 on 14-10-28.
//
//

#import "HNPassAddNewTableViewCell.h"

@interface HNPassAddNewTableViewCell()<UITextFieldDelegate>
@property (strong, nonatomic) id updataView;
@end

@implementation HNPassAddNewTableViewCell
bool bo;
-(id)init
{
    self = [super init];
    bo = false;
    return self;
}

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
    [self.uploadButton addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImage:)];
    [self.iconImageView addGestureRecognizer:singleTap1];
    
}

-(IBAction)uploadImage:(id)sender
{
    [self.delegate showImagePickView:self];
    self.updataView = self.iconImageView;
}

-(void)uploadClick
{
    [self.delegate showImagePickView:self];
    self.updataView = self.uploadButton;
}

-(void)updateImage:(NSString*)msg whithImage:(UIImage*)image
{
    if (!msg) {
        return;
    }
    if ([self.updataView isEqual:self.uploadButton]) {
        [self.uploadButton setTitle:@"已上传" forState:UIControlStateNormal];
        self.proposerData.IDcardImg = msg;
    }
    else
    {
        self.proposerData.Icon = msg;
        [self.iconImageView setImage:image];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    bo = true;
    [self.delegate moveScrollView:textField];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    bo = false;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.proposerData.name = self.nameTextField.text;
    self.proposerData.phone = self.phoneTextField.text;
    self.proposerData.IDcard = self.cardNOTextField.text;
    if (!bo) {
        [self.delegate finishMoveScrollView:textField];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
