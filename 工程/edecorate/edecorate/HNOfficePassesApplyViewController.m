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

@interface HNOfficePassesApplyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
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
@property (nonatomic) NSInteger tableCellMun;
@end

@implementation HNOfficePassesApplyViewController

-(id)initWithModel:(HNPassData *)model
{
    self = [super init];
    self.temporaryModel = model;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"Pass Apply", nil);
    
    
label:self.houseInfoMain.text = NSLocalizedString(@"House Information", nil) ;
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
    
    self.tableCellMun = 0;
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
    
    // Do any additional setup after loading the view from its nib.
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
    self.tableCellMun += 1;
    self.tableView.hidden = NO;
    [self.tableView reloadData ];
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
        
    }];
}

- (NSDictionary *)encodeWithTemporaryModel{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.temporaryModel.declareId,@"declareId", _temporaryModel.headcount,@"headcount",_temporaryModel.proposerId,@"proposerId",_temporaryModel.proposer,@"proposer",_temporaryModel.needItem,@"needItem",nil];
    //return dic;
    return nil;
    
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
    return  self.tableCellMun;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"addNewCell";
    HNPassAddNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNPassAddNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
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
