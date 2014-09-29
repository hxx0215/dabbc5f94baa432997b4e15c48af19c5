//
//  HNAcceptReturnGoodViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-29.
//
//

#import "HNAcceptReturnGoodViewController.h"
#import "UIView+AHKit.h"

@interface HNAcceptReturnGoodViewController ()
@property (strong, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@end

@implementation HNAcceptReturnGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.OKButton.layer.borderWidth = 1.0;
    self.OKButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.OKButton.width = 45;
    [self.OKButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    self.cancelButton.layer.borderWidth = 1.0;
    self.cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.cancelButton.width = 45;
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
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
}

- (IBAction)CancelButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
