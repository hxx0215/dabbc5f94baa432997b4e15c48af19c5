//
//  HNOfficePassesApplyViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-22.
//
//

#import "HNOfficePassesApplyViewController.h"
#import "HNOfficePassesViewController.h"
#import "UIView+AHKit.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNPassAddNewTableViewCell.h"
#import "HNDecorateChoiceView.h"
#import "HNUploadImage.h"

@interface HNOfficePassesApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,HNDecorateChoiceViewDelegate,HNPassAddNewTableViewCellDelegate>
@property (nonatomic,strong) IBOutlet UIScrollView *mainView;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoMain;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoTitle;
@property (nonatomic,strong) IBOutlet UILabel *houseInfo;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwer;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwerMobile;

@property (nonatomic,strong) IBOutlet UILabel *decorationCompanyTitle;
@property (nonatomic,strong) IBOutlet UILabel *decorationCompany;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMobile;

@property (nonatomic,strong) IBOutlet UILabel *personsLabel;

//@property (nonatomic,strong) IBOutlet UILabel *PasscardInfo;
//@property (nonatomic,strong) IBOutlet UILabel *passcardsum;
//@property (nonatomic,strong) IBOutlet UILabel *passcardManList;
@property (nonatomic,strong) IBOutlet UITextField *passcardName;
@property (nonatomic,strong) IBOutlet UITextField *passcardMobile;
@property (nonatomic,strong) IBOutlet UITextField *passcardIdcardNo;

@property (nonatomic,strong) IBOutlet UIButton *AddPassCardMan;

@property (nonatomic,strong) IBOutlet UILabel *passcardPerFee;
@property (nonatomic,strong) IBOutlet UILabel *passcardCount;
@property (nonatomic,strong) IBOutlet UILabel *passcardSumFee;
@property (nonatomic,strong) IBOutlet UILabel *depositPerFee;
@property (nonatomic,strong) IBOutlet UILabel *depositCount;
@property (nonatomic,strong) IBOutlet UILabel *depositSumFee;
@property (nonatomic,strong) IBOutlet UILabel *sumMoney;

@property (nonatomic,strong) IBOutlet UIView *payView;

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UIButton *uploadIdCardPic;
@property (nonatomic,strong) IBOutlet UIButton *uploadPic;
@property (nonatomic,strong) IBOutlet UIButton *submit;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) HNPassAddNewTableViewCell *addNewCell;

@property (strong, nonatomic) IBOutlet HNDecorateChoiceView *choiceDecorateView;
@end

@implementation HNOfficePassesApplyViewController

//-(id)initWithModel:(HNPassData *)model
//{
//    self = [super init];
//    self.temporaryModel = model;
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.temporaryModel = [[HNPassData alloc]init];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"Pass Apply", nil);
    
    self.houseInfoMain.text = NSLocalizedString(@"House Information", nil) ;
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfoTitle];
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.decorationCompanyTitle];
    
    [self labelWithTitle:self.temporaryModel.roomnumber label:self.houseInfo];
    [self labelWithTitle:self.temporaryModel.ownername label:self.houseOnwer];
    [self labelWithTitle:self.temporaryModel.ownerphone label:self.houseOnwerMobile];
    self.houseOnwer.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.houseOnwerMobile.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.houseOnwerMobile sizeToFit ];
    [self.houseOnwer sizeToFit ];
    self.houseOnwerMobile.right = self.view.width - 14;
    self.houseOnwer.right = self.houseOnwerMobile.left-5;
    
    [self labelWithTitle:self.temporaryModel.shopname label:self.decorationCompany];
    [self labelWithTitle:self.temporaryModel.principal label:self.decorationChargeMan];
    [self labelWithTitle:self.temporaryModel.EnterprisePhone label:self.decorationChargeMobile];
    self.decorationChargeMan.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.decorationChargeMobile.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.decorationChargeMobile sizeToFit ];
    [self.decorationChargeMan sizeToFit ];
    self.decorationChargeMobile.right = self.view.width - 14;
    self.decorationChargeMan.right = self.decorationChargeMobile.left-5;
    
    NSString *str = [[NSString alloc]init];
    for (int i=0; i<[self.temporaryModel.proposerItems count];i++) {
        HNPassProposerData* proposerData = self.temporaryModel.proposerItems[i];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@ ",proposerData.name]];
    }
    if ([self.temporaryModel.proposerItems count]) {
        
        //        [self labelWithTitle:proposerData.name label:self.decortionMan];
        //        [self labelWithTitle:proposerData.phone label:self.decorationManMobile];
        //        [self labelWithTitle:proposerData.IDcard  label:self.decorationIdCardNo];
        //        [self labelWithTitle:proposerData.Icon label:self.decorationIdCardPic];
        //        [self labelWithTitle:proposerData.isTransaction label:self.decorationPic];
    }
    self.personsLabel.text = str;
    
    int officepassPerFee=10,depositFee=30;
    int officepassCount=1,depositCount=1;
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassPerFee] label:self.passcardPerFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount] label:self.passcardCount];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",officepassCount*officepassPerFee] label:self.passcardSumFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositFee] label:self.depositPerFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount] label:self.depositCount];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee] label:self.depositSumFee];
    [self labelWithTitle:[NSString stringWithFormat:@"%d",depositCount*depositFee+officepassCount*officepassPerFee] label:self.sumMoney];
    
    
    [self.uploadIdCardPic sizeToFit];
    self.uploadIdCardPic.layer.borderWidth = 1.0;
    self.uploadIdCardPic.layer.borderColor = [UIColor blackColor].CGColor;
    [self.uploadPic sizeToFit];
    self.uploadPic.layer.borderWidth = 1.0;
    self.uploadPic.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNPassAddNewTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"addNewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    
    self.AddPassCardMan.layer.cornerRadius = 5.0;
    
    self.payView.top = self.personsLabel.bottom+24;
    [self.AddPassCardMan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submit.layer.cornerRadius = 5.0;
    [self.submit setTitle:NSLocalizedString(@"在线支付", nil) forState:UIControlStateNormal];
    [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submit setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    
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
    // Do any additional setup after loading the view from its nib.
}


- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
    self.houseInfo.text = model.roomName;
    self.houseOnwerMobile.text = model.ownerphone;
    self.houseOnwer.text = model.ownername;
    [self.houseOnwerMobile sizeToFit];
    [self.houseOnwer sizeToFit ];
    self.houseOnwerMobile.right = self.view.width - 14;
    self.houseOnwer.right = self.houseOnwerMobile.left-5;
    self.temporaryModel.declareId = model.declareId;
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    //[lab sizeToFit];
    //lab.font = [UIFont systemFontOfSize:12];
    //lab.numberOfLines = 2;
    //lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mainView.frame = [[UIScreen mainScreen] bounds];
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.payView.bottom+20);
}

- (IBAction)addNewClick:(id)sender
{
    self.tableView.hidden = NO;
    HNPassProposerData* data = [[HNPassProposerData alloc]init];
    [self.temporaryModel.proposerItems addObject:data];
    [self.tableView reloadData ];
    self.tableView.height = [self.temporaryModel.proposerItems count]*101+2;
    self.payView.top = self.tableView.bottom+24;
    
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.payView.bottom+20);
}

- (IBAction)checkOut:(id)sender
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithTemporaryModel] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.pass.list" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didCheckOut:) withObject:data waitUntilDone:YES];
        
    }];
}

-(void)didCheckOut:(NSData*)data
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
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"支付成功，您的申请已提交审核，请在审核通过够到物业管理处领取证件", nil) delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil,nil];
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

- (NSDictionary *)encodeWithTemporaryModel{
    
//    headcount	Y	施工总人数
//    declareId	Y	报建编号
//    proposerId	Y	申请用户userid
//    proposer	Y	申请人员信息JSON（realname：姓名，idcard：身份证号，phone：联系电话，idcardImg：身份证照片，icon：头像）
//    needItem	Y	缴费项json([{name:名称,price:价格,useUnit:单位,number:数量,IsSubmit:是否必缴,Isrefund:是否可退,totalMoney:总金额,sort:排序},{...}]
//                            
    NSArray *array = [[NSArray alloc]init];
    NSMutableArray *jsonArray = [[NSMutableArray alloc]init];//创建最外层的数组
    for (int i=0; i<[self.temporaryModel.proposerItems count]; i++) {
        HNPassProposerData *tModel = [self.temporaryModel.proposerItems objectAtIndex:i];
        
        NSDictionary *dic = [[NSMutableDictionary alloc]init];//创建内层的字典
        //申请人员信息JSON（realname：姓名，idcard：身份证号，phone：联系电话，idcardImg：身份证照片，icon：头像）
        [dic setValue:tModel.name forKey:@"realname"];
        [dic setValue:tModel.IDcard forKey:@"idcard"];
        [dic setValue:tModel.phone forKey:@"phone"];
        [dic setValue:tModel.IDcardImg forKey:@"idcardImg"];
        [dic setValue:tModel.Icon forKey:@"icon"];
        [jsonArray addObject:dic];
    }
    array = [NSArray arrayWithArray:jsonArray];
    
    NSArray *array2 = [[NSArray alloc]init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.temporaryModel.declareId,@"declareId", [NSString stringWithFormat:@"%ld",(unsigned long)[self.temporaryModel.proposerItems count]],@"headcount",[HNLoginData shared].uid,@"proposerId",[array JSONString],@"proposer",[array2 JSONString],@"needItem",self.temporaryModel.declareId,@"totalcost",nil];
    NSLog(@"%@",[dic JSONString]);
    
    return dic;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //if(alertView.tag==1)
        //self.temporaryModel.status = TemporaryStatusApplying;
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.temporaryModel.proposerItems count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"addNewCell";
    HNPassAddNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNPassAddNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
    }
    cell.delegate = self;
    cell.proposerData = [self.temporaryModel.proposerItems objectAtIndex:indexPath.row];
    return cell;
}
 #pragma mark - HNPassAddNewTableViewCellDelegate

- (void)moveScrollView:(UITextField*)textFiled
{
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width,self.payView.bottom+20+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textFiled convertPoint:CGPointMake(0, 0) toView:self.mainView];//把当前的textField的坐标映射到scrollview上
    if(self.mainView.contentOffset.y-pt.y+self.navigationController.navigationBar.height<=0)//判断最上面不要去滚动
        [self.mainView setContentOffset:CGPointMake(0, pt.y-self.navigationController.navigationBar.height) animated:YES];//华东
}

- (void)finishMoveScrollView:(UITextField*)textFiled
{
    [UIView animateWithDuration:0.30f animations:^{
        
        self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.payView.bottom+20);
    }];
}

- (void)showImagePickView:(id)cell
{
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    self.addNewCell = cell;
}

 #pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.addNewCell) {
        return;
    }
    
    CGFloat scaleSize = 0.1f;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    [HNUploadImage UploadImage:scaledImage block:^(NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.addNewCell updateImage:msg whithImage:image];
        self.addNewCell = nil;
    }];
    
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
