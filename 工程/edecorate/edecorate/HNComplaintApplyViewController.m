//
//  HNComplaintApplyViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-20.
//
//

#import "HNComplaintApplyViewController.h"
#import "HNCommbox.h"
#import "UIView+AHKit.h"

@interface HNComplaintApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)IBOutlet UIScrollView *mainView;

@property (nonatomic, strong)IBOutlet UILabel *houseInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *houseInfLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersLabel;
@property (nonatomic, strong)IBOutlet UILabel *ownersPhoneNumberLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionUnitTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionUnitLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionPersonPhoneNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UITextView *complaintContansTextView;

@property (nonatomic, strong)IBOutlet UILabel *complaintInformationTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintCategoryTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintObjectTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *complaintIssueTitleLable;
@property (nonatomic, strong)IBOutlet UILabel *evidenceTitleLable;
@property (nonatomic, strong)IBOutlet UITextField *complaintObjectTF;
@property (nonatomic, strong)IBOutlet UITextField *complaintOCategoryTF;

@property (nonatomic, strong)UIImagePickerController *imagePicker;

@property (nonatomic, strong)HNCommbox* commbox;
@property (nonatomic, strong)UIPickerView* complaintCategoryPickView;
@property (nonatomic, strong)NSArray* complaintCategoryPickerArray;
@property (strong, nonatomic) UIView* textOKView;

@property (nonatomic) CGFloat mainViewFramRectTop;
@end

@implementation HNComplaintApplyViewController

-(id)initWithModel:(HNComplaintData *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfMainLabel];
    
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfTitleLabel];
    [self labelWithTitle:self.temporaryModel.room label:self.houseInfLabel];
    
    [self labelWithTitle:@"laochen"  label:self.constructionPersonLabel];
    [self labelWithTitle:@"13330333033"  label:self.ownersPhoneNumberLabel];
    
    //constructionUnitTitleLabel
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.constructionUnitTitleLabel];
    
    [self labelWithTitle:@"feiniao"  label:self.constructionUnitLabel];
    
    
    [self labelWithTitle:@"laochen"  label:self.ownersLabel];
    
    [self labelWithTitle:@"13330333033"  label:self.constructionPersonPhoneNumberLabel];
    
    self.ownersLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.ownersPhoneNumberLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.ownersPhoneNumberLabel sizeToFit ];
    [self.ownersLabel sizeToFit ];
    self.ownersPhoneNumberLabel.right = self.view.width - 14;
    self.ownersLabel.right = self.ownersPhoneNumberLabel.left-5;
    
    self.constructionPersonLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.constructionPersonPhoneNumberLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.constructionPersonPhoneNumberLabel sizeToFit ];
    [self.constructionPersonLabel sizeToFit ];
    self.constructionPersonPhoneNumberLabel.right = self.view.width - 14;
    self.constructionPersonLabel.right = self.constructionPersonPhoneNumberLabel.left-5;
    
    //Complaint Information
    [self labelWithTitle:NSLocalizedString(@"Complaint Information", nil) label:self.complaintInformationTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Category", nil) label:self.complaintCategoryTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Object", nil) label:self.complaintObjectTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Issue", nil) label:self.complaintIssueTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Evidence", nil) label:self.evidenceTitleLable];

    
    self.complaintContansTextView.layer.borderWidth = 1.0;
    self.complaintContansTextView.layer.borderColor = [UIColor blackColor].CGColor;

    [self.uploadButton setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
    self.uploadButton.layer.borderWidth = 1.0;
    self.uploadButton.font = [UIFont systemFontOfSize:12];
    self.uploadButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.commitButton setTitle:NSLocalizedString(@"Submit complaint", nil) forState:UIControlStateNormal];
    self.commitButton.layer.cornerRadius = 5.0;
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =self;
    self.imagePicker.sourceType = sourceType;
    self.imagePicker.allowsEditing = NO;
    
    
//    NSMutableArray* arr = [[NSMutableArray alloc] init];
//    [arr addObject:@"投诉业主"];
//    [arr addObject:@"投诉装修单位"];
//    _commbox = [[HNCommbox alloc] initWithFrame:CGRectMake(self.houseInfLabel.left, self.complaintCategoryTitleLable.top, self.complaintContansTextView.width, self.commitButton.height) withArray:arr];
//    [self.view addSubview:_commbox];
    
    self.complaintObjectTF.delegate = self;
    self.complaintContansTextView.delegate = self;
    
    
    self.complaintCategoryPickerArray = [NSArray arrayWithObjects:@"投诉业主",@"投诉装修单位", nil];
    self.complaintCategoryPickView = [[UIPickerView alloc]init];
    self.complaintCategoryPickView.delegate = self;
    self.complaintCategoryPickView.dataSource = self;
    [self.complaintCategoryPickView setFrame:CGRectMake(0, 0, 320, 200)];
    self.complaintCategoryPickView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.complaintCategoryPickView.showsSelectionIndicator = YES;
    self.complaintOCategoryTF.inputView = self.complaintCategoryPickView;
    self.complaintOCategoryTF.delegate = self;
    self.textOKView = [[UIView alloc]init];
    self.textOKView.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.textOKView addSubview:button];
    button.width = self.textOKView.width = 50;
    button.height = self.textOKView.height = self.complaintOCategoryTF.height;
    [button setTitle:@"OK" forState:UIControlStateNormal];
    self.textOKView.hidden = YES;
    [self.mainView addSubview:self.textOKView];
    [button addTarget:self action:@selector(OKTextClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    self.complaintContansTextView.inputAccessoryView = topView;
}

-(void)dismissKeyBoard
{
    [self.complaintContansTextView resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mainViewFramRectTop = [self.view convertRect:self.view.bounds toView:[[UIApplication sharedApplication] keyWindow]].origin.y;
    
    self.mainView.frame = self.view.bounds;
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
//    [lab sizeToFit];
//    lab.font = [UIFont systemFontOfSize:12];
//    lab.numberOfLines = 2;
//    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

-(void)OKTextClick
{
    NSInteger row = [self.complaintCategoryPickView selectedRowInComponent:0];
    self.complaintOCategoryTF.text = [self.complaintCategoryPickerArray objectAtIndex:row];
    [self.complaintOCategoryTF resignFirstResponder];
    
}

- (IBAction)commit:(id)sender
{
//    self.temporaryModel.complaintInfo.complaintCategory = self.complaintOCategoryTF.text;
//    self.temporaryModel.complaintInfo.complaintObject = self.complaintObjectTF.text;
//    self.temporaryModel.complaintInfo.complaintIssue = self.complaintContansTextView.text;
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"已提交投诉" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag=1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)upload:(id)sender{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    //[self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    if (textField == self.complaintOCategoryTF) {
        self.textOKView.right = textField.right;
        self.textOKView.bottom = textField.bottom;
        self.textOKView.hidden = NO;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.textOKView.hidden = YES;

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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.30f animations:^{
        self.view.top = -10;
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.30f animations:^{
        self.view.top = self.mainViewFramRectTop;
    }];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.complaintCategoryPickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.complaintCategoryPickerArray objectAtIndex:row];
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    return 50.0;
    
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
