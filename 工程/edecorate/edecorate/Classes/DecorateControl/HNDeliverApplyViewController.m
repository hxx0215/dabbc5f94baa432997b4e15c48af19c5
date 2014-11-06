//
//  HNDeliverApplyViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-1.
//
//

#import "HNDeliverApplyViewController.h"
#import "UIView+AHKit.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNDecorateChoiceView.h"
#import "HNDeliverData.h"
#import "HNDeliveApplyTableViewCell.h"

@interface HNDeliverApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,HNDecorateChoiceViewDelegate,UITextFieldDelegate,HNDeliveApplyAddNewTableViewCellDelegate>
@property bool bo;
@property (strong, nonatomic) HNDecorateChoiceView *choiceDecorateView;
@property (nonatomic, strong)IBOutlet UIScrollView *mainView;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoMain;
@property (nonatomic,strong) IBOutlet UILabel *decorationMain;
@property (nonatomic,strong) IBOutlet UILabel *personMain;
@property (nonatomic,strong) IBOutlet UILabel *payMain;
@property (nonatomic,strong) IBOutlet UILabel *godInfoMain;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoTitle;
@property (nonatomic, strong)IBOutlet UILabel* roomNameLabel;
@property (nonatomic, strong)IBOutlet UILabel* ownerphoneLabel;
@property (nonatomic, strong)IBOutlet UILabel* ownernameLabel;

@property (nonatomic,strong) IBOutlet UILabel *decorationCompanyTitle;

@property (nonatomic, strong)IBOutlet UILabel* productTitle;
@property (nonatomic, strong)IBOutlet UILabel* btimeTitleLabel;
@property (nonatomic, strong)IBOutlet UILabel* etimeTitleLabel;

@property (nonatomic, strong)IBOutlet UITextField* productTextField;
@property (nonatomic, strong)IBOutlet UITextField* bTimeTextField;
@property (nonatomic, strong)IBOutlet UITextField* eTimeTextField;
@property (nonatomic, strong)IBOutlet UITextField* cField;

@property (strong, nonatomic) IBOutlet UIView *viewRoom;
@property (strong, nonatomic) IBOutlet UIView *viewPrincipal ;
@property (strong, nonatomic) IBOutlet UIView *viewInformation;
@property (strong, nonatomic) IBOutlet UIView *viewPrice;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UIButton *AddPassCardMan;

@property (nonatomic, strong) HNDeliverData* model;
@property (nonatomic, strong)IBOutlet UIButton* commitButton;

@property (strong, nonatomic) UIDatePicker *pickerView;
@end

@implementation HNDeliverApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bo = false;
    self.navigationItem.title = NSLocalizedString(@"Delivery&Installation Apply", nil);
    
    self.houseInfoMain.text = NSLocalizedString(@"House Information", nil) ;
    self.houseInfoTitle.text = NSLocalizedString(@"House Information", nil) ;
    self.decorationCompanyTitle.text = NSLocalizedString(@"Construction unit", nil) ;
    
    self.ownernameLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.ownerphoneLabel.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    
    self.productTitle.text = NSLocalizedString(@"送货安装产品", nil);
    self.btimeTitleLabel.text = NSLocalizedString(@"Start Time", nil);
    self.etimeTitleLabel.text = NSLocalizedString(@"End Time", nil);
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNDeliveApplyTableViewCell class]) bundle:nil];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.viewInformation.bottom, self.mainView.width, 150)];
    [self.mainView addSubview:self.tableView];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"DeliverApplyCell"];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.viewPrice.top = self.viewInformation.bottom+24;
    
    self.AddPassCardMan.layer.cornerRadius = 5.0;
    
    self.commitButton.layer.cornerRadius = 5.0;
    [self.commitButton setTitle:NSLocalizedString(@"在线支付", nil) forState:UIControlStateNormal];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    
    
    self.choiceDecorateView = [[HNDecorateChoiceView alloc]initWithFrame:CGRectMake(12, 12, self.view.bounds.size.width-24, 25)];
    [self.mainView addSubview:self.choiceDecorateView];
    self.choiceDecorateView.delegate = self;
    
    self.model = [[HNDeliverData alloc]init];
    
    
    self.pickerView = [[UIDatePicker alloc]init];
    self.pickerView.frame = CGRectMake(0, 500, 300, 200);
    self.pickerView.backgroundColor = [UIColor grayColor];
    //self.pickerView.hidden = YES;
    self.pickerView.datePickerMode = UIDatePickerModeDate;
    self.eTimeTextField.inputView = self.pickerView;
    self.bTimeTextField.inputView = self.pickerView;
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //[topView setBarStyle:UIBarStyleBlack];
    topView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(OKTextClick)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    self.eTimeTextField.inputAccessoryView = topView;
    self.bTimeTextField.inputAccessoryView = topView;
    
    [HNUIStyleSet UIStyleSetRoundView:self.houseInfoMain];
    [HNUIStyleSet UIStyleSetRoundView:self.decorationMain];
    [HNUIStyleSet UIStyleSetRoundView:self.personMain];
    [HNUIStyleSet UIStyleSetRoundView:self.payMain];
    [HNUIStyleSet UIStyleSetRoundView:self.godInfoMain];
}

-(void)OKTextClick
{
    NSDate *selected = [self.pickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    self.cField.text = destDateString;
    [self.cField resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mainView.frame = self.view.bounds;
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.viewPrice.bottom+20);
}


- (void)updataDecorateInformation:(HNDecorateChoiceModel*)model
{
    self.roomNameLabel.text = model.roomName;
    self.ownerphoneLabel.text = model.ownerphone;
    self.ownernameLabel.text = model.ownername;
    [self.ownerphoneLabel sizeToFit];
    [self.ownernameLabel sizeToFit ];
    self.ownerphoneLabel.right = self.view.width - 14;
    self.ownernameLabel.right = self.ownerphoneLabel.left-5;
    self.model.declareId = model.declareId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commit:(id)sender
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithModel] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"set.install.list" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didcommit:) withObject:data waitUntilDone:YES];
    }];
    
}

-(void)didcommit:(NSData*)data
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

- (NSDictionary *)encodeWithModel{
    /*
     declareId	Y	报建编号
     product		送货产品名称
     btime		送货开始时间
     etime		送货结束时间
     proposer		申请人员信息json[{realname:姓名,idcard:身份证号,phone:联系电话,idcardImg:身份证照片,icon:头像},{...}]）
     needItem		缴费项json([{name:名称,price:价格,useUnit:单位,number:数量,IsSubmit:是否必缴,Isrefund:是否可退,totalMoney:总金额,sort:排序},{...}]
     */
    

    NSArray *array = [[NSArray alloc]init];
    NSMutableArray *jsonArray = [[NSMutableArray alloc]init];//创建最外层的数组
    for (int i=0; i<[self.model.proposerItems count]; i++) {
        HNDeliverProposerItem *tModel = [self.model.proposerItems objectAtIndex:i];
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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.model.declareId,@"declareId", self.productTextField.text,@"product",self.bTimeTextField.text,@"btime",self.eTimeTextField.text,@"etime",[array JSONString],@"proposer",[array2 JSONString],@"needItem",nil];
    NSLog(@"%@",[dic JSONString]);
    
    return dic;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //if(alertView.tag==1)
    //self.temporaryModel.status = TemporaryStatusApplying;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate
- (IBAction)addNewClick:(id)sender
{
    self.tableView.hidden = NO;
    HNDeliverProposerItem* data = [[HNDeliverProposerItem alloc]init];
    [self.model.proposerItems addObject:data];
    [self.tableView reloadData ];
    self.tableView.height = [self.model.proposerItems count]*105+2;
    self.viewPrice.top = self.tableView.bottom+24;
    
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.viewPrice.bottom+20);
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.model.proposerItems count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"DeliverApplyCell";
    HNDeliveApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNDeliveApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
    }
    [cell setTextFieldDelegate:self proposerData:[self.model.proposerItems objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark HNDeliveApplyAddNewTableViewCellDelegate
- (void)willDidMoveScrollView:(UITextField*)textFiled
{
    [self textFieldShouldBeginEditing:textFiled];
}

- (void)didMoveScrollView:(UITextField*)textFiled
{
    [self textFieldDidBeginEditing:textFiled];
}

- (void)finishMoveScrollView:(UITextField*)textFiled
{
    [self textFieldDidEndEditing:textFiled];
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    self.cField = textField;
    self.bo = false;
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.bo = true;
    NSLog(@"textFieldShouldBeginEditing");
    self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width,self.viewPrice.bottom+20+216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:self.mainView];//把当前的textField的坐标映射到scrollview上
    if(self.mainView.contentOffset.y-pt.y+self.navigationController.navigationBar.height<=0)//判断最上面不要去滚动
        [self.mainView setContentOffset:CGPointMake(0, pt.y-self.navigationController.navigationBar.height) animated:YES];//华东
    return YES;
}

-(void)doKeyboard
{
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (!self.bo) {
        //开始动画
        [UIView animateWithDuration:0.30f animations:^{
            self.mainView.frame = self.view.bounds;
            self.mainView.contentSize = CGSizeMake(self.view.bounds.size.width, self.viewPrice.bottom+20);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
