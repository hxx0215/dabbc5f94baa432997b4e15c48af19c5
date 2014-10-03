//
//  VolumeViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNVolumeViewController.h"
#include "UIView+AHKit.h"

@interface HNVolumeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentedControl;
@property (strong, nonatomic) IBOutlet UILabel *volumeNOTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumePWTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeStatusLabel;
@property (strong, nonatomic) IBOutlet UITextField *volumeNOTextField;
@property (strong, nonatomic) IBOutlet UITextField *volumePWTextField;
@property (strong, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@end

@implementation HNVolumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.viewSegmentedControl setTitle:NSLocalizedString(@"Consumer verification", nil) forSegmentAtIndex:0];
    [self.viewSegmentedControl setTitle:NSLocalizedString(@"Verify effective", nil) forSegmentAtIndex:1];
    
    self.volumeNOTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.volumeNOTextField.delegate = self;
    self.volumePWTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.volumePWTextField.delegate = self;
    self.volumePWTextField.secureTextEntry = YES;
    [self labelWithTitle:NSLocalizedString(@"Volume No.", nil) label:self.volumeNOTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Consumer password", nil) label:self.volumePWTitleLabel];
    
    self.OKButton.layer.borderWidth = 1.0;
    self.OKButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.OKButton.width = 45;
    self.OKButton.hidden = YES;
    [self.OKButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    self.cancelButton.layer.borderWidth = 1.0;
    self.cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.cancelButton.width = 45;
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    self.cancelButton.hidden = YES;
    
    
    [self.viewSegmentedControl addTarget:self action:@selector(segmentClick:)forControlEvents:UIControlEventValueChanged];
    
    self.volumeStatusLabel.text = nil;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(OKButtonClick:)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(CancelButtonClick:)];
    self.navigationItem.leftBarButtonItem = cancel;
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}


- (IBAction)OKButtonClick:(id)sender
{
    NSInteger Index = self.viewSegmentedControl.selectedSegmentIndex;
    switch (Index)
    {
        case 0:
            self.volumeStatusLabel.text = @"验证通过";
            break;
        case 1:
            self.volumeStatusLabel.text = @"此消费卷有效";
            break;
        default:
            break;
    }
}

- (IBAction)CancelButtonClick:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
}

- (IBAction)segmentClick:(id)sender {
    
    NSInteger Index = self.viewSegmentedControl.selectedSegmentIndex;
    switch (Index)
    {
        case 0:
            self.volumePWTextField.hidden = NO;
            self.volumePWTitleLabel.hidden = NO;
            break;
        case 1:
            self.volumePWTextField.hidden = YES;
            self.volumePWTitleLabel.hidden = YES;
            break;
        default:
            break;
    }
    self.volumeStatusLabel.text = nil;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
