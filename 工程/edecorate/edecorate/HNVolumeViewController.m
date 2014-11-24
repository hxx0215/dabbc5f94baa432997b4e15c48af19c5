//
//  VolumeViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNVolumeViewController.h"
#include "UIView+AHKit.h"
#include "JSONKit.h"
#include "MBProgressHUD.h"

@interface HNVolumeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentedControl;
@property (strong, nonatomic) IBOutlet UILabel *volumeNOTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumePWTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeStatusLabel;
@property (strong, nonatomic) IBOutlet UITextField *volumeNOTextField;
@property (strong, nonatomic) IBOutlet UITextField *volumePWTextField;
@property (strong, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIView *view2;
@end

@implementation HNVolumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    
    [self.viewSegmentedControl setTitle:NSLocalizedString(@"Consumer verification", nil) forSegmentAtIndex:0];
    [self.viewSegmentedControl setTitle:NSLocalizedString(@"Verify effective", nil) forSegmentAtIndex:1];
    self.viewSegmentedControl.tintColor = [UIColor projectGreen];
    self.volumeNOTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.volumeNOTextField.delegate = self;
    self.volumeNOTextField.placeholder = NSLocalizedString(@"在此输入消费券号", nil);
    self.volumePWTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.volumePWTextField.delegate = self;
    self.volumePWTextField.secureTextEntry = YES;
    [self labelWithTitle:NSLocalizedString(@"Volume No.", nil) label:self.volumeNOTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Consumer password", nil) label:self.volumePWTitleLabel];
    self.volumePWTextField.placeholder = NSLocalizedString(@"在此输入消费券密码", nil);
    
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
//    [lab sizeToFit];
//    lab.font = [UIFont systemFontOfSize:12];
//    lab.numberOfLines = 2;
    
    //lab.layer.borderColor = [UIColor blackColor].CGColor;
}


- (IBAction)OKButtonClick:(id)sender
{
//    if (!self.volumeNOTextField.text) {
//        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"请输入消费券号" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
//        [alert show];
//        return;
//    }
    
    NSInteger Index = self.viewSegmentedControl.selectedSegmentIndex;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    switch (Index)
    {
        case 0:
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.volumeNOTextField.text,@"couponid",self.volumePWTextField.text,@"couponpwd",nil];
            NSString *jsonStr = [dic JSONString];
            request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.coupon.validation" Params:jsonStr]];
            
        }
            break;
        case 1:
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.volumeNOTextField.text,@"couponid",nil];
            NSString *jsonStr = [dic JSONString];
            request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.coupon.validation" Params:jsonStr]];
            
        }
            break;
        default:
            break;
    }
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didCommit:) withObject:data waitUntilDone:YES];
    }];
}


-(void)didCommit:(NSData *)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSString *total = [dic objectForKey:@"total"];
        if (total.integerValue)
        {
            NSArray *array = [dic objectForKey:@"data"];
            NSDictionary *dic2 = [array objectAtIndex:0];
            self.volumeStatusLabel.text = [dic2 objectForKey:@"msg"];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Loading Fail", nil) message:NSLocalizedString(@"Please try again", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
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
            self.view2.hidden = NO;
            break;
        case 1:
            self.view2.hidden = YES;
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
