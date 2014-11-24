//
//  HNTemporaryApplyViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import "HNTemporaryApplyViewController.h"
#import "UIView+AHKit.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNDecorateChoiceView.h"
#import "HNTemporaryApplyTableViewCell.h"
#import "HNUploadImage.h"

/*
 "House Information" = "房屋信息";
 "Owners" = "业主";
 "Phone number" = "手机号";
 "Construction unit" = "施工单位";
 "Person in charge of construction" = "施工负责人";
 "Notice the use of fire" = "用火须知";
 "Fire units" = "用火单位";
 "Use of fire by" = "用火是由";
 "Fire tools" = "用火工具";
 "Fire load" = "用火负荷";
 "Start Time" = "开始时间";
 "End Time" = "结束时间";
 "Operator" = "操作人";
 "Phone" = "联系电话";
 "Valid documents" = "有效证件";
 "Upload" = "上传";
 "Submission" = "提交申请";
 */
@interface HNTemporaryApplyViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate,HNDecorateChoiceViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    bool bo;
    NSString *myData[8];
}

@property (strong, nonatomic) IBOutlet UIButton *noticeFireButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) IBOutlet HNDecorateChoiceView *choiceDecorateView;


@property (strong, nonatomic) IBOutlet UITextField *timeTextField;

@property (nonatomic, strong)UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIDatePicker *pickerView;

@property (strong, nonatomic) NSString* imagePath;
@property (strong, nonatomic) UIImage *imageUpload;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray1;
@property (nonatomic, strong) NSArray *titleArray2;
@property (nonatomic, strong) NSArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataMutableArray2;

@property (strong, nonatomic) UIToolbar * topView;
@property (strong,nonatomic) UIView *commitView;
@property (nonatomic)CGFloat contentSizeHeight;
@end

#define HSPACE 10
#define WSPACE 5
#define TSPACEPER 0.1
#define LABELHEIGHT 20
#define STARTTOP 10

@implementation HNTemporaryApplyViewController

-(id)initWithType:(HNTemporaryType)type;
{
    self = [super init];
    switch (type) {
        case FIRE:
            self.temporaryModel = [[HNTemporaryFireModel alloc]init];
            
            break;
        case POWER:
            self.temporaryModel = [[HNTemporaryElectroModel alloc]init];
            break;
            
        default:
            break;
    }
    self.temporaryModel.type = type;
    self.dataMutableArray2 = [[NSMutableArray alloc]initWithCapacity:8];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.titleArray1 = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Owners", nil),NSLocalizedString(@"Phone number", nil),NSLocalizedString(@"Construction unit", nil),NSLocalizedString(@"Person in charge of construction", nil),NSLocalizedString(@"Phone number", nil),nil];
    
    self.dataArray1 = [[NSArray alloc] initWithObjects:self.temporaryModel.huseInfo.owners,self.temporaryModel.huseInfo.ownersPhoneNumber,self.temporaryModel.huseInfo.constructionUnit,self.temporaryModel.huseInfo.constructionPerson,self.temporaryModel.huseInfo.constructionPersonPhoneNumber,nil];
    
    if (self.temporaryModel.type==FIRE) {
        HNTemporaryFireModel* fmodel = (HNTemporaryFireModel*)self.temporaryModel;
        self.titleArray2 =   [[NSArray alloc] initWithObjects:NSLocalizedString(@"Fire units", nil),NSLocalizedString(@"Use of fire by", nil),NSLocalizedString(@"Fire tools", nil),NSLocalizedString(@"Fire load", nil),NSLocalizedString(@"Start Time", nil),NSLocalizedString(@"End Time", nil),NSLocalizedString(@"Operator", nil),NSLocalizedString(@"Phone", nil),NSLocalizedString(@"Valid documents", nil),nil];
        
//        self.dataArray2 = [[NSArray alloc] initWithObjects:fmodel.dataInfo.fireUnits,fmodel.dataInfo.useOfFireBy,fmodel.dataInfo.fireTools,fmodel.dataInfo.fireLoad,fmodel.dataInfo.startTime,fmodel.dataInfo.endTime,fmodel.dataInfo.operatorPerson,fmodel.dataInfo.phone,fmodel.dataInfo.validDocuments,nil];
        
    }
    else{
        HNTemporaryElectroModel* emodel = (HNTemporaryElectroModel*)self.temporaryModel;
        self.titleArray2 =   [[NSArray alloc] initWithObjects:NSLocalizedString(@"Electro units", nil),NSLocalizedString(@"Use of electro by", nil),NSLocalizedString(@"Electro tools", nil),NSLocalizedString(@"Electro load", nil),NSLocalizedString(@"Start Time", nil),NSLocalizedString(@"End Time", nil),NSLocalizedString(@"Operator", nil),NSLocalizedString(@"Phone", nil),NSLocalizedString(@"Valid documents", nil),nil];
        
//        self.dataArray2 = [[NSArray alloc] initWithObjects:emodel.dataInfo.electroEnterprise,emodel.dataInfo.electroCause,emodel.dataInfo.electroTool,emodel.dataInfo.electroLoad,emodel.dataInfo.electroBTime,emodel.dataInfo.electroETime,emodel.dataInfo.electroOperator,emodel.dataInfo.electroPhone,emodel.dataInfo.PapersImg ,nil];
    }
    
    [self.noticeFireButton sizeToFit];
    
    
    
    //@property (strong, nonatomic) IBOutlet UIButton *commitButton;
    

//    [self.uploadButton setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
//    self.uploadButton.layer.cornerRadius = 5.0;
//    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.uploadButton setBackgroundColor:[UIColor colorWithRed:0.0 green:72.0/255.0 blue:245.0/255.0 alpha:1.0]];
//    
//    [self.commitButton setTitle:NSLocalizedString(@"Submission", nil) forState:UIControlStateNormal];
//    self.commitButton.layer.cornerRadius = 5.0;
//    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.commitButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    
    self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 30)];
    self.choiceDecorateView.delegate = self;
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =self;
    self.imagePicker.sourceType = sourceType;
    self.imagePicker.allowsEditing = NO;
    
    
    self.pickerView = [[UIDatePicker alloc]init];
    self.pickerView.frame = CGRectMake(0, 500, 300, 200);
    self.pickerView.backgroundColor = [UIColor grayColor];
    //self.pickerView.hidden = YES;
    self.pickerView.datePickerMode = UIDatePickerModeDate;
    
    self.topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    self.topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(OKTextClick)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [self.topView  setItems:buttonsArray];
    
    bo = false;

        // Do any additional setup after loading the view.
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.frame = self.view.bounds;
    self.commitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:NSLocalizedString(@"提交申请", nil) forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitView addSubview:purchase];
    [self movewButton];
}

-(void)movewButton
{
    CGSize size = self.tableView.contentSize;
    self.commitView.top = size.height;
    [self.tableView addSubview:self.commitView];
    size.height += self.commitView.height;
    self.tableView.contentSize = size;
    self.contentSizeHeight = size.height;
}


- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
    self.temporaryModel.declareId = model.declareId;
    self.temporaryModel.roomName = model.roomName;
    self.temporaryModel.huseInfo.owners = model.ownername;
    self.temporaryModel.huseInfo.ownersPhoneNumber = model.ownerphone;
    self.dataArray1 = [[NSArray alloc] initWithObjects:self.temporaryModel.huseInfo.owners,self.temporaryModel.huseInfo.ownersPhoneNumber,self.temporaryModel.huseInfo.constructionUnit,self.temporaryModel.huseInfo.constructionPerson,self.temporaryModel.huseInfo.constructionPersonPhoneNumber,nil];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:YES];
}

- (IBAction)commit:(id)sender
{
    NSString *method;
    NSString *jsonStr;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setModelData];
    switch (self.temporaryModel.type) {
        case FIRE:
        {
            method = @"set.temporary.fire";
            jsonStr = [[self encodeWithFireModel:self.temporaryModel] JSONString];
        }
            break;
        case POWER:
        {
            method = @"set.temporary.electro";
            jsonStr = [[self encodeWithPowerModel:self.temporaryModel] JSONString];
        }
            break;
            
        default:
            break;
    }
    
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:method Params:jsonStr]];
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
        if ([[dic objectForKey:@"total"] integerValue]>=1)
        {
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"已提交审核" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
            alert.tag=1;
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

- (IBAction)noticeFireClicked:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"用火须知" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag = 2;
    [alert show];

}

- (NSDictionary *)encodeWithFireModel:(HNTemporaryModel *)model{
    HNTemporaryFireModel* fmodel = (HNTemporaryFireModel*)model;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fmodel.declareId,@"declareId", fmodel.dataInfo.fireUnits,@"fireEnterprise",fmodel.dataInfo.useOfFireBy,@"fireCause",fmodel.dataInfo.fireTools,@"fireTool",fmodel.dataInfo.fireLoad,@"fireLoad",fmodel.dataInfo.startTime,@"fireBTime",fmodel.dataInfo.endTime,@"fireETime",fmodel.dataInfo.operatorPerson,@"fireOperator",fmodel.dataInfo.phone,@"firePhone",fmodel.dataInfo.validDocuments,@"PapersImg",nil];
    return dic;
    
}

-(void)setModelData
{
    switch (self.temporaryModel.type) {
        case FIRE:
        {
            HNTemporaryFireModel* fmodel = (HNTemporaryFireModel*)self.temporaryModel;
            NSInteger index = 0;
            fmodel.dataInfo.fireUnits = myData[index++];
            fmodel.dataInfo.useOfFireBy = myData[index++];
            fmodel.dataInfo.fireTools = myData[index++];
            fmodel.dataInfo.fireLoad = myData[index++];
            fmodel.dataInfo.startTime = myData[index++];
            fmodel.dataInfo.endTime = myData[index++];
            fmodel.dataInfo.operatorPerson = myData[index++];
            fmodel.dataInfo.phone = myData[index++];
            fmodel.dataInfo.validDocuments = self.imagePath;
        }
            break;
        case POWER:
        {
            HNTemporaryElectroModel* fmodel = (HNTemporaryElectroModel*)self.temporaryModel;
            NSInteger index = 0;
            fmodel.dataInfo.electroEnterprise = myData[index++];            fmodel.dataInfo.electroCause = myData[index++];            fmodel.dataInfo.electroTool = myData[index++];            fmodel.dataInfo.electroLoad = myData[index++];
            fmodel.dataInfo.electroBTime = myData[index++];
            fmodel.dataInfo.electroETime = myData[index++];
            fmodel.dataInfo.electroOperator = myData[index++];
            fmodel.dataInfo.electroPhone = myData[index++];
            fmodel.dataInfo.PapersImg = self.imagePath;
        }
            break;
            
        default:
            break;
    };
}

- (NSDictionary *)encodeWithPowerModel:(HNTemporaryModel *)model{
    HNTemporaryElectroModel* fmodel = (HNTemporaryElectroModel*)model;

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fmodel.declareId,@"declareId", fmodel.dataInfo.electroEnterprise,@"electroEnterprise",fmodel.dataInfo.electroCause,@"electroCause",fmodel.dataInfo.electroTool,@"electroTool",fmodel.dataInfo.electroLoad,@"electroLoad",fmodel.dataInfo.electroBTime,@"electroBTime",fmodel.dataInfo.electroETime,@"electroETime",fmodel.dataInfo.electroOperator,@"electroOperator",fmodel.dataInfo.electroPhone,@"electroPhone",fmodel.dataInfo.PapersImg,@"PapersImg",nil];
    return dic;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)
    {
        //self.temporaryModel.status = TemporaryStatusApplying;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
//    [lab sizeToFit];
//    lab.font = [UIFont systemFontOfSize:12];
//    lab.numberOfLines = 2;
//
//    lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (IBAction)upload:(id)sender{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    [self requestForPostWithURLString:image];
}

-(void)requestForPostWithURLString:(UIImage*)image
{
    [HNUploadImage UploadImage:image block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (msg) {
            self.imagePath = msg;
            self.imageUpload = image;
            [self.uploadButton setImage:image forState:UIControlStateNormal];
        }
    }];
     
    
}



//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
//}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    bo = true;
    NSLog(@"textFieldShouldBeginEditing");
    self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width,self.contentSizeHeight+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.tableView];//把当前的textField的坐标映射到scrollview上
    if(self.tableView.contentOffset.y-pt.y<=0)//判断最上面不要去滚动
        [self.tableView setContentOffset:CGPointMake(0, pt.y) animated:YES];//华东
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    bo = false;
    if (textField.tag == 4 || textField.tag == 5) {
        self.timeTextField = textField;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField==self.timeTextField) {
        NSDate *selected = [self.pickerView date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *destDateString = [dateFormatter stringFromDate:selected];
        textField.text = destDateString;
    }
    if (!bo) {
        //开始动画
        [UIView animateWithDuration:0.30f animations:^{
            self.tableView.contentSize = CGSizeMake(self.view.bounds.size.width, self.contentSizeHeight);
        }];
    }
    myData[textField.tag] = textField.text;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

-(void)OKTextClick
{
    [self.timeTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        
        return 5;
    }
    else
        return 9;
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
        if(!self.choiceDecorateView)
        {
            self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 30)];
            self.choiceDecorateView.delegate = self;
            self.choiceDecorateView.left = 5;
            self.choiceDecorateView.centerY = contentView.height / 2;
        }
        self.choiceDecorateView.updataDecorateInformation = YES;
        [contentView addSubview:self.choiceDecorateView];
    }else
    {
        UILabel *label = [[UILabel alloc] init];
        label.text = NSLocalizedString(@"申请信息", nil);
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
    switch (indexPath.row)
    {
        case 8:
            return 60;
            break;
        default:
            return 30;
            break;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (0==indexPath.section) {
        static NSString *identy = @"DefaultApplyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identy];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self.titleArray1 objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor darkTextColor];
        if(indexPath.row<[self.dataArray1 count])
            cell.detailTextLabel.text = [self.dataArray1 objectAtIndex:indexPath.row];
        else
            cell.detailTextLabel.text = nil;
        return cell;
    }
    else {
        static NSString *identy = @"ApplyCell";
        HNTemporaryApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        if (!cell)
        {
            cell = [[HNTemporaryApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title.text = [self.titleArray2 objectAtIndex:indexPath.row];
        if (8 == indexPath.row) {
            [cell setStyle:1];
            if(self.imageUpload)
                [cell.photo setImage:self.imageUpload forState:UIControlStateNormal];
            [cell.photo addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
            self.uploadButton = cell.photo;
        }
        else
        {
            [cell setStyle:0];
            cell.textField.placeholder = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"请在此输入", nil),cell.title.text];
            cell.textField.delegate = self;
            if(indexPath.row == 4 || indexPath.row == 5)
            {
                cell.textField.inputView = self.pickerView;
                cell.textField.inputAccessoryView = self.topView;
            }
            else
            {
                cell.textField.inputView = nil;
                cell.textField.inputAccessoryView = nil;
            }
            cell.textField.text = myData[indexPath.row];
            cell.textField.tag = indexPath.row;
        }
        
        
        
        return cell;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
