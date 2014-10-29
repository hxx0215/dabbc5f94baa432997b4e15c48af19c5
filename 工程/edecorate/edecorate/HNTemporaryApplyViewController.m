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
@property (strong, nonatomic) UIView* textOKView;
@property (nonatomic)NSInteger keyboardHeight;
@property (strong, nonatomic) UITextField* currntTF;
@property (nonatomic) CGFloat mainViewFramRectTop;
@end

#define HSPACE 10
#define WSPACE 5
#define TSPACEPER 0.1
#define LABELHEIGHT 20
#define STARTTOP 10

@implementation HNTemporaryApplyViewController

-(id)initWithModel:(HNTemporaryModel *)model
{
    self = [super init];
    self.temporaryModel = model;
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
    
    NSInteger i=0;
    self.fireunitsTF.tag = i++;
    self.useOfFireByTF.tag = i++;
    self.fireToolsTF.tag = i++;
    self.fireLoadTF.tag = i++;
    self.startTimeTF.tag = i++;
    self.endTimeTF.tag = i++;
    self.operatorTF.tag = i++;
    self.phoneTF.tag = i++;
    //self.validDocumentsTF.tag = i++;
    self.fireunitsTF.delegate = self;
    self.useOfFireByTF.delegate = self;
    self.fireToolsTF.delegate = self;
    self.fireLoadTF.delegate = self;
    self.startTimeTF.delegate = self;
    self.endTimeTF.delegate = self;
    self.operatorTF.delegate = self;
    self.phoneTF.delegate = self;
    //self.validDocumentsTF.delegate = self;
    
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
    self.endTimeTF.delegate = self;
    self.startTimeTF.inputView = self.pickerView;
    self.startTimeTF.delegate = self;
    
    self.textOKView = [[UIView alloc]init];
    self.textOKView.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.textOKView addSubview:button];
    button.width = self.textOKView.width = 50;
    button.height = self.textOKView.height = self.startTimeTF.height;
    [button setTitle:@"OK" forState:UIControlStateNormal];
    self.textOKView.hidden = YES;
    [self.view addSubview:self.textOKView];
    [button addTarget:self action:@selector(OKTextClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.keyboardHeight = 0;
    self.currntTF = nil;
    

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
            int commitStatus = 1;
            if (commitStatus)
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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fmodel.declareId,@"declareId", fmodel.dataInfo.fireUnits,@"fireEnterprise",fmodel.dataInfo.useOfFireBy,@"fireCause",fmodel.dataInfo.fireTools,@"fireTool",fmodel.dataInfo.fireLoad,@"fireLoad",fmodel.dataInfo.startTime,@"fireBTime",fmodel.dataInfo.endTime,@"fireETime",fmodel.dataInfo.operatorPerson,@"fireOperator",fmodel.dataInfo.phone,@"firePhone",fmodel.dataInfo.validDocuments,@"PapersImg",nil];
    return dic;
    
}


- (NSDictionary *)encodeWithPowerModel:(HNTemporaryModel *)model{
    HNTemporaryElectroModel* fmodel = (HNTemporaryElectroModel*)model;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fmodel.declareId,@"declareId", fmodel.dataInfo.electroEnterprise,@"electroEnterprise",fmodel.dataInfo.electroCause,@"electroCause",fmodel.dataInfo.electroTool,@"electroTool",fmodel.dataInfo.electroLoad,@"electroLoad",fmodel.dataInfo.electroBTime,@"electroBTime",fmodel.dataInfo.electroETime,@"electroETime",fmodel.dataInfo.electroOperator,@"electroOperator",fmodel.dataInfo.electroPhone,@"electroPhone",fmodel.dataInfo.PapersImg,@"PapersImg",nil];
    return dic;
    
}

- (IBAction)beginEdit:(id)sender {
    NSLog(@"beginEdit");
    
    UITextField *tf = (UITextField *)sender;
    
    if(tf.textInputView.top>tf.bottom)
    {
        NSLog(@"123");
    }
    if(tf==self.endTimeTF||tf==self.startTimeTF)
    {
        self.textOKView.right = tf.right;
        self.textOKView.bottom = tf.bottom;
        self.textOKView.hidden = NO;
    }
    self.currntTF = tf;
    [self moveViewToShowTF];
}

- (IBAction)editEnd:(id)sender {
    NSLog(@"editEnd");
        if (self.currntTF) {
        self.textOKView.hidden = YES;
    }
    
    self.currntTF = nil;
    
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
    self.textOKView.hidden = YES;
    if(self.currntTF)
    {
        NSDate *selected = [self.pickerView date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:selected];
        self.currntTF.text = destDateString;
        [self.currntTF resignFirstResponder];
    }
    
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
    
    UIImage *images = [UIImage imageNamed:@"押金退款.png"];
    //得到图片的data
    NSData* datas = UIImagePNGRepresentation(images);
    
    CGFloat scaleSize = 0.5f;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *_data = UIImageJPEGRepresentation(scaledImage, 1.0f);
    NSString *_encodedImageStr = [datas base64EncodedStringWithOptions:1];
    _encodedImageStr = [_encodedImageStr stringByReplacingOccurrencesOfString:@"+" withString:@"|JH|"];
    _encodedImageStr = [_encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@"|KG|"];
    _encodedImageStr = [_encodedImageStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@"|HC|"];
    //Replace("|JH|", "+").Replace("|KG|", " ").Replace("|HC|", "\r\n");
    
    //MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = NSLocalizedString(@"Loading", nil);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"testImage.png",@"name",nil];
    NSString *jsonStr = [dic JSONString];
    NSURL *URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.picture.add" Params:jsonStr]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:_encodedImageStr options:1];
    [request setHTTPBody:data];
    NSString *contentType = @"multipart/form-data";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
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
    [self requestForPostWithURLString];

    //[self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];;
}

-(void)requestForPostWithURLString
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"testImage.png",@"name",nil];
    NSString *jsonStr = [dic JSONString];
    NSURL *URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.picture.add" Params:jsonStr]];
    
//    NSString *paramsJson = [JsonFactory dictoryToJsonStr:URLString];
//    //    NSLog(@"requestParamstr %@",paramsJson);
//    //加密
//    paramsJson = [[FBEncryptorDES encrypt:paramsJson
//                                keyString:@"SDFL#)@F"] uppercaseString];
//    NSString *signs= [NSString stringWithFormat:@"SDFL#)@FMethod%@Params%@SDFL#)@F",method,paramsJson];
//    signs = [[FBEncryptorDES md5:signs] uppercaseString];
//    //    http://113.105.159.107:84
//    //    icbcapp.intsun.com
//    NSString *requestStr = [NSString stringWithFormat:@"http://61.158.187.140:8088/home/?Method=%@&Params=%@&Sign=%@",method,paramsJson,signs];
//    NSLog(@"request %@",requestStr);
    
    
    //    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    NSString *TWITTERFON_FORM_BOUNDARY = @"AABBCC";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
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
    UIImage *images = [UIImage imageNamed:@"押金退款.png"];
    //得到图片的data
    NSData* imageData = UIImagePNGRepresentation(images);
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
    //    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //设置接受response的data
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *urlData = [NSURLConnection
                       sendSynchronousRequest:request
                       returningResponse: &response
                       error: &error];
    //    return [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding] autorelease];
    //    DLog(@"DATA:%@, error:%@",URLData, error);
    NSString *retStr = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
    NSLog(@"%@",retJson);
    //    json = [ZZ3DESEncrypt decrypt:json keyString:METHODKEY];//解密
    //    DLog(@"解密JSON:%@",json);
    //    json = [json URLDecodedString];//将josn转化为普通格式
    //    DLog(@"普通格式JSON:%@",json);
    //
    //    NSDictionary *returnDictionary = [[json objectFromJSONString] retain];
    //    DLog(@"解析的字典：%@",returnDictionary);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mainViewFramRectTop = [self.view convertRect:self.view.bounds toView:[[UIApplication sharedApplication] keyWindow]].origin.y;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    self.mainView.frame = [self.view bounds];
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.commitButton.bottom+20);
    self.mainViewFramRectTop = self.view.top;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"keyboardWasShown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"hight_hitht:%f",kbSize.height);
    if(0 == self.keyboardHeight)
    {
        self.keyboardHeight = kbSize.height;
        [self moveViewToShowTF];
    }
    self.keyboardHeight = kbSize.height;
    
}

-(void)moveViewToShowTF
{
    
    if (0 == self.keyboardHeight || nil == self.currntTF)
    {
        return;
    }
    self.view.top = self.mainViewFramRectTop;
    
    CGRect rect = [self.currntTF convertRect:self.currntTF.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    CGFloat offset = self.keyboardHeight - ([UIScreen mainScreen].bounds.size.height -(rect.origin.y + rect.size.height));
    if(offset > 0){
        [UIView animateWithDuration:0.30f animations:^{
            self.view.top = self.mainViewFramRectTop-offset;
        }];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.view.top = self.mainViewFramRectTop;
    self.keyboardHeight = 0;
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
