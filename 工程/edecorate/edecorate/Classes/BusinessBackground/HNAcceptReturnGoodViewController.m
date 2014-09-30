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

@property (strong, nonatomic) IBOutlet UITextView *remarksTextView;

@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *consigneeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *remarksTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *consigneeLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@end

/*
 "Return Address" = "Return Address";
 "Consignee" = "Consignee";
 "Remarks" = "Remarks";
 */
@implementation HNAcceptReturnGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self labelWithTitle:NSLocalizedString(@"Return Address", nil) label:self.addressTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Consignee", nil) label:self.consigneeTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone", nil) label:self.phoneTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Remarks", nil) label:self.remarksTitleLabel];
    
//    self.OKButton.layer.borderWidth = 1.0;
//    self.OKButton.layer.borderColor = [UIColor blackColor].CGColor;
//    self.OKButton.width = 45;
//    [self.OKButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
//    self.cancelButton.layer.borderWidth = 1.0;
//    self.cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
//    self.cancelButton.width = 45;
//    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    self.remarksTextView.layer.borderWidth = 1.0;
    self.remarksTextView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.navigationItem.title = NSLocalizedString(@"Agreed to return", nil);
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(OKButtonClick:)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(CancelButtonClick:)];
    self.navigationItem.leftBarButtonItem = cancel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateData];
    
}

-(void)updateData
{
    [self labelWithTitle:@"123" leftLabel:self.addressTitleLabel label:self.addressLabel];
    [self labelWithTitle:@"123" leftLabel:self.consigneeTitleLabel label:self.consigneeLabel];
    [self labelWithTitle:@"123" leftLabel:self.phoneTitleLabel label:self.phoneLabel];
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 2;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)labelWithTitle:(NSString *)title leftLabel:(UILabel*)leftlab label:(UILabel*)lab
{
    [lab setText:title];
    [lab sizeToFit];
    lab.font = [UIFont systemFontOfSize:11];
    lab.numberOfLines = 2;
    lab.left = leftlab.left+leftlab.width;
    lab.top = leftlab.top;
    lab.height = leftlab.height;
    
    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (IBAction)OKButtonClick:(id)sender
{
}

- (IBAction)CancelButtonClick:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
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
