//
//  ProfileChangeViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-27.
//
//

#import "HNProfileChangeViewController.h"
#import "HNAreaPickerView.h"
#include "UIView+AHKit.h"

@interface HNProfileChangeViewController ()<UITextFieldDelegate,HNAreaPickerDelegate>
//
@property (strong, nonatomic) HNAreaPickerView *locatePicker;


@property (strong, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (retain, nonatomic) IBOutlet UILabel *areaTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *postalTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopkeeperTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *onlineServiceTitleLabel;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *categoryTextField;
@property (retain, nonatomic) IBOutlet UITextField *areaAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *postalTextField;
@property (strong, nonatomic) IBOutlet UITextField *shopkeeperTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *onlineServiceTextField;

@property (strong, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) UITextField* currentTextField;

@property (strong, nonatomic) UIView* textOKView;
@end

@implementation HNProfileChangeViewController
@synthesize locatePicker=_locatePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self labelWithTitle:NSLocalizedString(@"Name", nil) label:self.nameTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Category", nil) label:self.categoryTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Address", nil) label:self.areaTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Postal Code", nil) label:self.postalTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Street address", nil) label:self.addressTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Shopkeeper", nil) label:self.shopkeeperTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone", nil) label:self.phoneTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Online Service (QQ)", nil) label:self.onlineServiceTitleLabel];
    
    self.OKButton.layer.borderWidth = 1.0;
    self.OKButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.OKButton.width = 45;
    [self.OKButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    self.cancelButton.layer.borderWidth = 1.0;
    self.cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.cancelButton.width = 45;
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    self.locatePicker = [[HNAreaPickerView alloc] initWithStyle:HNAreaPickerWithStateAndCityAndDistrict delegate:self];
    self.areaAddressTextField.inputView = self.locatePicker;
    
    self.textOKView = [[UIView alloc]init];
    self.textOKView.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.textOKView addSubview:button];
    button.width = self.textOKView.width = 50;
    button.height = self.textOKView.height = self.areaAddressTextField.height;
    [button setTitle:@"OK" forState:UIControlStateNormal];
    self.textOKView.hidden = YES;
    [self.view addSubview:self.textOKView];
    [button addTarget:self action:@selector(OKTextClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil) style:UIBarButtonItemStyleDone target:self action:@selector(OKButtonClick:)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(CancelButtonClick:)];
    self.navigationItem.leftBarButtonItem = cancel;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.nameTextField.text = self.model.name;
    self.categoryTextField.text = self.model.category;
    self.addressTextField.text = self.model.address;
    self.shopkeeperTextField.text = self.model.shopkeeper;
    self.phoneTextField.text = self.model.phone;
    self.onlineServiceTextField.text = self.model.onlineService;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.currentTextField = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)OKTextClick
{
    [self.areaAddressTextField resignFirstResponder];
    
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
    self.model.name = self.nameTextField.text;
    self.model.category = self.categoryTextField.text;
    self.model.address = self.addressTextField.text;
    self.model.shopkeeper = self.shopkeeperTextField.text;
    self.model.phone = self.phoneTextField.text;
    self.model.onlineService = self.onlineServiceTextField.text;
    //[self.navigationController popViewControllerAnimated:YES];
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
}

- (IBAction)CancelButtonClick:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    self.navigationController.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.userInteractionEnabled = YES;
    }];
}


#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HNAreaPickerView *)picker
{
    if (picker.pickerStyle == HNAreaPickerWithStateAndCityAndDistrict) {
        self.areaAddressTextField.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    }
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentTextField = textField;
    if ([textField isEqual:self.areaAddressTextField]) {
        self.textOKView.right = textField.right;
        self.textOKView.top = textField.top;
        self.textOKView.hidden = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentTextField = nil;
    self.textOKView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.currentTextField resignFirstResponder];
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
