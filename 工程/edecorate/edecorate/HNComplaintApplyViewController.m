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
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNDecorateChoiceView.h"
#import "HNUploadImage.h"
#import "HNComplaintApplyTableViewCell.h"

@interface HNComplaintApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,HNDecorateChoiceViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)IBOutlet UIScrollView *mainView;

@property (nonatomic, strong)IBOutlet UILabel *houseInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *constructionInfMainLabel;
@property (nonatomic, strong)IBOutlet UILabel *complaintInfMainLabel;

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

@property (nonatomic, strong)IBOutlet UITextField *complaintBody;
@property (nonatomic, strong)IBOutlet UITextField *complaintComplainant;
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

@property (strong, nonatomic) NSString* imageName;

@property (strong, nonatomic) IBOutlet HNDecorateChoiceView *choiceDecorateView;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIToolbar * topView;

@end

@implementation HNComplaintApplyViewController

-(id)init
{
    self = [super init];
    self.temporaryModel = [[HNComplaintData alloc]init];;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    

    
    //Complaint Information
    [self labelWithTitle:NSLocalizedString(@"Complaint Information", nil) label:self.complaintInformationTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Category", nil) label:self.complaintCategoryTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Object", nil) label:self.complaintObjectTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Complaint Issue", nil) label:self.complaintIssueTitleLable];
    [self labelWithTitle:NSLocalizedString(@"Evidence", nil) label:self.evidenceTitleLable];

    
    self.complaintContansTextView.layer.borderWidth = 1.0;
    self.complaintContansTextView.layer.borderColor = [UIColor blackColor].CGColor;

    [self.uploadButton setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
    self.uploadButton.layer.cornerRadius = 5.0;
    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.uploadButton setBackgroundColor:[UIColor colorWithRed:0.0 green:72.0/255.0 blue:245.0/255.0 alpha:1.0]];
    
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
    
    self.topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    self.topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [self.topView setItems:buttonsArray];
    
    
    [HNUIStyleSet UIStyleSetRoundView:self.houseInfMainLabel];
    [HNUIStyleSet UIStyleSetRoundView:self.complaintInfMainLabel];
    [HNUIStyleSet UIStyleSetRoundView:self.constructionInfMainLabel];
}


- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
    self.houseInfLabel.text = model.roomName;
    self.ownersPhoneNumberLabel.text = model.ownerphone;
    self.ownersLabel.text = model.ownername;
    [self.ownersPhoneNumberLabel sizeToFit];
    [self.ownersLabel sizeToFit ];
    self.ownersPhoneNumberLabel.right = self.view.width - 14;
    self.ownersLabel.right = self.ownersPhoneNumberLabel.left-5;
    self.temporaryModel.declareId = model.declareId;
}

-(void)dismissKeyBoard
{
    [self.complaintContansTextView resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:NSLocalizedString(@"提交投诉", nil) forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:purchase];
    CGSize size = self.tableView.contentSize;
    view.top = size.height;
    [self.tableView addSubview:view];
    size.height += view.height;
    self.tableView.contentSize = size;
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
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithModel] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.user.complaints" Params:jsonStr]];
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
        int commitStatus = 1;
        if (commitStatus)
        {
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"已提交投诉" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
            [alert show];
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

- (NSDictionary *)encodeWithModel{
    /*
    body		商家编号
    complainant		投诉人姓名（负责人）
    complainantId		商家编号
    complainfile 		投诉附件
    complainObject 		投诉对象
    complainProblem 		投诉问题
    complainType 		投诉类别
    declareId 		报建Id
     */
    self.temporaryModel.complainObject = self.complaintObjectTF.text;
    self.temporaryModel.complainType = self.complaintOCategoryTF.text;
    self.temporaryModel.complainProblem = self.complaintContansTextView.text;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.complaintBody.text,@"body", self.complaintComplainant.text,@"complainant",[HNLoginData shared].mshopid,@"complainantId",self.imageName,@"complainfile",self.temporaryModel.complainObject,@"complainObject",self.temporaryModel.complainProblem,@"complainProblem",self.temporaryModel.complainType,@"complainType",self.temporaryModel.declareId,@"declareId",nil];
    return dic;
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
    
    UIImage *scaledImage = [HNUploadImage ScaledImage:image scale:0.5];
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    //[self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];;
    [HNUploadImage UploadImage:scaledImage block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (msg) {
            self.imageName = msg;
            [self.uploadButton setTitle:@"已上传" forState:UIControlStateNormal];
        }
    }];
}

bool bo = false;
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    bo = false;
    NSLog(@"textFieldDidBeginEditing");
    if (textField == self.complaintOCategoryTF) {
        self.textOKView.right = textField.right;
        self.textOKView.bottom = textField.bottom;
        self.textOKView.hidden = NO;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    bo = true;
    NSLog(@"textFieldShouldBeginEditing");
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.mainView];//把当前的textField的坐标映射到scrollview上
    if(self.mainView.contentOffset.y-pt.y+self.navigationController.navigationBar.height<=0)//判断最上面不要去滚动
        [self.mainView setContentOffset:CGPointMake(0, pt.y-self.navigationController.navigationBar.height) animated:YES];//华东
    return YES;
}

-(void)doKeyboard
{
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.textOKView.hidden = YES;
    
    if (!bo) {
        //开始动画
        [UIView animateWithDuration:0.30f animations:^{
            self.mainView.frame = self.view.bounds;
            self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
        }];
    }
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    bo = true;
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textView convertPoint:CGPointMake(0, 0) toView:self.mainView];//把当前的textField的坐标映射到scrollview上
    if(self.mainView.contentOffset.y-pt.y+self.navigationController.navigationBar.height<=0)//判断最上面不要去滚动
        [self.mainView setContentOffset:CGPointMake(0, pt.y-self.navigationController.navigationBar.height) animated:YES];//华东
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    bo = false;
//    [UIView animateWithDuration:0.30f animations:^{
//        self.view.top = -10;
//    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    [UIView animateWithDuration:0.30f animations:^{
//        self.view.top = self.mainViewFramRectTop;
//    }];
    if (!bo) {
        //开始动画
        [UIView animateWithDuration:0.30f animations:^{
            self.mainView.frame = self.view.bounds;
            self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
        }];
    }
    
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

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        
        return 0;
    }
    else
        return 6;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    
    if (section == 0){
        self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 30)];
        self.choiceDecorateView.delegate = self;
        self.choiceDecorateView.left = 5;
        self.choiceDecorateView.centerY = contentView.height / 2;
        [contentView addSubview:self.choiceDecorateView];
    }else
    {
        UILabel *label = [[UILabel alloc] init];
        label.text = NSLocalizedString(@"投诉信息", nil);
        label.font = [UIFont systemFontOfSize:15];
        label.width = contentView.width -10;
        label.numberOfLines = 2;
        [label sizeToFit];
        label.textColor = [UIColor whiteColor];
        label.left = 5;
        label.centerY = contentView.height / 2;
        [contentView addSubview:label];
        
    }
    [view addSubview:contentView];

    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"complaintApplyCell";
    HNComplaintApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell)
    {
        cell = [[HNComplaintApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    
    if (1==indexPath.section){
        NSString *titleString = nil;
        NSString *detailString = nil;
        
        switch (indexPath.row) {
            case 0:
            {
                titleString = NSLocalizedString(@"投诉人姓名：", nil);
                detailString = NSLocalizedString(@"点此输入投诉人姓名", nil);
                self.complaintComplainant = cell.textView;
            }
                break;
            case 1:
            {
                titleString = NSLocalizedString(@"投诉内容：", nil);
                detailString = NSLocalizedString(@"点此输入投诉内容", nil);
                self.complaintBody = cell.textView;
            }
                break;
            case 2:
            {
                titleString = NSLocalizedString(@"投诉类别：", nil);
                detailString = NSLocalizedString(@"点此输入投诉类别", nil);
                self.complaintOCategoryTF = cell.textView;
            }
                break;
            case 3:
            {
                titleString = NSLocalizedString(@"投诉对象：", nil);
                detailString = NSLocalizedString(@"点此输入投诉对象", nil);
                self.complaintObjectTF = cell.textView;
            }
                break;
            case 4:
            {
                titleString = NSLocalizedString(@"投诉问题：", nil);
                detailString = NSLocalizedString(@"点此输入投诉问题", nil);
                self.complaintContansTextView = cell.textView2;
                cell.textView2.hidden = NO;
                cell.textView.hidden = YES;
                self.complaintContansTextView.inputAccessoryView = self.topView;

            }
                break;
            case 5:
            {
                titleString = NSLocalizedString(@"证明材料：", nil);
                detailString = NSLocalizedString(@"点此输入投诉人图片", nil);
                self.complaintObjectTF = cell.textView;
                
            }
                break;
                
            default:
                break;
        }
        cell.title.text = titleString;
        cell.textView.placeholder = detailString;
        cell.textView.delegate = self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 7.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                /*} else if (indexPath.row == 0) {
                 CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                 CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                 addLine = YES;*/
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
            
        }
    }
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
