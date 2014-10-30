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
@interface HNTemporaryApplyViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate, UINavigationControllerDelegate,HNDecorateChoiceViewDelegate>
{
    bool bo;
}
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
@property (strong, nonatomic) IBOutlet UILabel *temporaryApplyMainLable;
@property (strong, nonatomic) IBOutlet UILabel *fireunitsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *useOfFireByTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireToolsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireLoadTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *operatorTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *validDocumentsTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *noticeFireButton;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UILabel *uploadTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) IBOutlet HNDecorateChoiceView *choiceDecorateView;

@property (strong, nonatomic) IBOutlet UITextField *fireunitsTF;
@property (strong, nonatomic) IBOutlet UITextField *useOfFireByTF;
@property (strong, nonatomic) IBOutlet UITextField *fireToolsTF;
@property (strong, nonatomic) IBOutlet UITextField *fireLoadTF;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTF;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTF;
@property (strong, nonatomic) IBOutlet UITextField *operatorTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
//@property (strong, nonatomic) IBOutlet UITextField *validDocumentsTF;

@property (nonatomic, strong)UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIDatePicker *pickerView;
//@property (strong, nonatomic) UIView* textOKView;

@property (strong, nonatomic) NSString* imagePath;

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
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.houseInfMainLabel.text = NSLocalizedString(@"House Information", nil);
    self.houseInfTitleLabel.text = NSLocalizedString(@"House Information", nil);
    self.constructionUnitTitleLabel.text = NSLocalizedString(@"Construction unit", nil);
    
    [self labelWithTitle:self.temporaryModel.huseInfo.houseInf label:self.houseInfLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionPerson  label:self.constructionPersonLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.ownersPhoneNumber  label:self.ownersPhoneNumberLabel];
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.constructionUnitTitleLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionUnit  label:self.constructionUnitLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.owners  label:self.ownersLabel];
    [self labelWithTitle:self.temporaryModel.huseInfo.constructionPersonPhoneNumber  label:self.constructionPersonPhoneNumberLabel];
    
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
    
    if(self.temporaryModel.type==FIRE)
    {
        [self labelWithTitle:NSLocalizedString(@"Fire Apply", nil) label:self.temporaryApplyMainLable];
        [self labelWithTitle:NSLocalizedString(@"Fire units", nil) label:self.fireunitsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Use of fire by", nil) label:self.useOfFireByTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Fire tools", nil) label:self.fireToolsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Fire load", nil) label:self.fireLoadTitleLabel];
        [self.noticeFireButton setTitle:NSLocalizedString(@"Notice the use of fire", nil) forState:UIControlStateNormal];
        
    
    }else{
        [self labelWithTitle:NSLocalizedString(@"Electro Apply", nil) label:self.temporaryApplyMainLable];
        [self labelWithTitle:NSLocalizedString(@"Electro units", nil) label:self.fireunitsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Use of electro by", nil) label:self.useOfFireByTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Electro tools", nil) label:self.fireToolsTitleLabel];
        [self labelWithTitle:NSLocalizedString(@"Electro load", nil) label:self.fireLoadTitleLabel];
        [self.noticeFireButton setTitle:NSLocalizedString(@"Notice the use of electro", nil) forState:UIControlStateNormal];
        
    }
    [self.noticeFireButton sizeToFit];
    
    [self labelWithTitle:NSLocalizedString(@"Start Time", nil) label:self.startTimeTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"End Time", nil) label:self.endTimeTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Operator", nil) label:self.operatorTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Phone", nil) label:self.phoneTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Valid documents", nil) label:self.validDocumentsTitleLabel];
    [self labelWithTitle:NSLocalizedString(@"Upload", nil) label:self.uploadTitleLabel];
    
    //@property (strong, nonatomic) IBOutlet UIButton *commitButton;
    

    [self.uploadButton setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
    [self.uploadButton sizeToFit];
    self.uploadButton.layer.borderWidth = 1.0;
    self.uploadButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.commitButton setTitle:NSLocalizedString(@"Submission", nil) forState:UIControlStateNormal];
    self.commitButton.layer.cornerRadius = 5.0;
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    
    self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 25)];
    [self.mainView addSubview:self.choiceDecorateView];
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
    self.endTimeTF.inputView = self.pickerView;
    self.startTimeTF.inputView = self.pickerView;
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(OKTextClick)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    self.startTimeTF.inputAccessoryView = topView;
    self.endTimeTF.inputAccessoryView = topView;
    
//    self.textOKView = [[UIView alloc]init];
//    self.textOKView.backgroundColor = [UIColor grayColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.textOKView addSubview:button];
//    button.width = self.textOKView.width = 50;
//    button.height = self.textOKView.height = self.startTimeTF.height;
//    [button setTitle:@"OK" forState:UIControlStateNormal];
//    self.textOKView.hidden = YES;
//    [self.view addSubview:self.textOKView];
//    [button addTarget:self action:@selector(OKTextClick) forControlEvents:UIControlEventTouchUpInside];
    
    bo = false;

        // Do any additional setup after loading the view.
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
    self.temporaryModel.roomName = model.roomName;
    self.temporaryModel.huseInfo.owners = model.ownername;
    self.temporaryModel.huseInfo.ownersPhoneNumber = model.ownerphone;
}

- (IBAction)commit:(id)sender
{
    NSString *method;
    NSString *jsonStr;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
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
        
    }];


}

- (IBAction)noticeFireClicked:(id)sender
{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:@"用火须知" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil,nil];
    alert.tag = 2;
    [alert show];

}

- (NSDictionary *)encodeWithFireModel:(HNTemporaryModel *)model{
    HNTemporaryFireModel* fmodel = (HNTemporaryFireModel*)model;
    
    fmodel.dataInfo.fireUnits = self.fireunitsTF.text;
    fmodel.dataInfo.useOfFireBy = self.useOfFireByTF.text;
    fmodel.dataInfo.fireTools = self.fireToolsTF.text;
    fmodel.dataInfo.fireLoad = self.fireLoadTF.text;
    fmodel.dataInfo.startTime = self.startTimeTF.text;
    fmodel.dataInfo.endTime = self.endTimeTF.text;
    fmodel.dataInfo.operatorPerson = self.operatorTF.text;
    fmodel.dataInfo.phone = self.phoneTF.text;
    fmodel.dataInfo.validDocuments = self.imagePath;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fmodel.declareId,@"declareId", fmodel.dataInfo.fireUnits,@"fireEnterprise",fmodel.dataInfo.useOfFireBy,@"fireCause",fmodel.dataInfo.fireTools,@"fireTool",fmodel.dataInfo.fireLoad,@"fireLoad",fmodel.dataInfo.startTime,@"fireBTime",fmodel.dataInfo.endTime,@"fireETime",fmodel.dataInfo.operatorPerson,@"fireOperator",fmodel.dataInfo.phone,@"firePhone",fmodel.dataInfo.validDocuments,@"PapersImg",nil];
    return dic;
    
}


- (NSDictionary *)encodeWithPowerModel:(HNTemporaryModel *)model{
    HNTemporaryElectroModel* fmodel = (HNTemporaryElectroModel*)model;
    
    fmodel.dataInfo.electroEnterprise = self.fireunitsTF.text;
    fmodel.dataInfo.electroCause = self.useOfFireByTF.text;
    fmodel.dataInfo.electroTool = self.fireToolsTF.text;
    fmodel.dataInfo.electroLoad = self.fireLoadTF.text;
    fmodel.dataInfo.electroBTime = self.startTimeTF.text;
    fmodel.dataInfo.electroETime = self.endTimeTF.text;
    fmodel.dataInfo.electroOperator = self.operatorTF.text;
    fmodel.dataInfo.electroPhone = self.phoneTF.text;
    fmodel.dataInfo.PapersImg = self.imagePath;
    
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
    
    CGFloat scaleSize = 0.5f;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self requestForPostWithURLString:scaledImage];
}

-(void)requestForPostWithURLString:(UIImage*)image
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"testImage.png",@"name",nil];
    NSString *jsonStr = [dic JSONString];
    NSURL *URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.picture.add" Params:jsonStr]];
    
    //    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    NSString *TWITTERFON_FORM_BOUNDARY = @"AABBCC";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    
    ////添加分界线，换行---文件要先声明
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"imgFile\"; filename=\"testImage.JPEG\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/JPEG\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    //UIImage *images = [UIImage imageNamed:@"押金退款.png"];
    //得到图片的data
    NSData* imageData = UIImagePNGRepresentation(image);
    [myRequestData appendData:imageData];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //建立连接，设置代理
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSLog(@"%@",retJson);
            NSDictionary* dic = [retJson objectFromJSONString];
            //    {"verification":true,"total":1,"data":[{"state":1,"msg":"http://113.105.159.115/Picture/201410/302117447717.png"}],"error":null}
            if ([[dic objectForKey:@"total"] integerValue]>=1)
            {
                NSArray* array = [dic objectForKey:@"data"];
                NSDictionary *dicData = [array objectAtIndex:0];
                self.imagePath = [dicData objectForKey:@"msg"];
                [self.uploadButton setTitle:@"已上传" forState:UIControlStateNormal];
                [self.uploadButton sizeToFit];
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
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    bo = true;
    NSLog(@"textFieldShouldBeginEditing");
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width,self.commitButton.bottom+20+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.mainView];//把当前的textField的坐标映射到scrollview上
    if(self.mainView.contentOffset.y-pt.y+self.navigationController.navigationBar.height<=0)//判断最上面不要去滚动
        [self.mainView setContentOffset:CGPointMake(0, pt.y-self.navigationController.navigationBar.height) animated:YES];//华东
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    bo = false;
    NSLog(@"beginEdit");
    //[self moveViewToShowTF];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField==self.endTimeTF||textField==self.startTimeTF) {
        NSDate *selected = [self.pickerView date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *destDateString = [dateFormatter stringFromDate:selected];
        textField.text = destDateString;
    }
    if (!bo) {
        //开始动画
        [UIView animateWithDuration:0.30f animations:^{
            self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
        }];
    }
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
    [self.endTimeTF resignFirstResponder];
    [self.startTimeTF resignFirstResponder];
}


-(void)moveViewToShowTF
{
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
