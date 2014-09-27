//
//  VolumeViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "VolumeViewController.h"

@interface VolumeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentedControl;
@property (strong, nonatomic) IBOutlet UILabel *volumeNOTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumePWTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeStatusLabel;
@property (strong, nonatomic) IBOutlet UITextField *volumeNOTextField;
@property (strong, nonatomic) IBOutlet UITextField *volumePWTextField;
@property (strong, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation VolumeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.volumeNOTextField.delegate = self;
    self.volumePWTextField.delegate = self;
}


- (IBAction)OKButtonClick:(id)sender
{
}

- (IBAction)CancelButtonClick:(id)sender
{
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
