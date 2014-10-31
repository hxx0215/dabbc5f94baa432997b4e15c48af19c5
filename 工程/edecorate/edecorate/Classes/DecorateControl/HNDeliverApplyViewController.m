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

@interface HNDeliverApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,HNDecorateChoiceViewDelegate,UITextFieldDelegate>
@property bool bo;
@property (strong, nonatomic) HNDecorateChoiceView *choiceDecorateView;
@property (nonatomic, strong)IBOutlet UIScrollView *mainView;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoMain;
@property (nonatomic,strong) IBOutlet UILabel *houseInfoTitle;
@property (nonatomic, strong)IBOutlet UILabel* roomNameLabel;
@property (nonatomic, strong)IBOutlet UILabel* ownerphoneLabel;
@property (nonatomic, strong)IBOutlet UILabel* ownernameLabel;

@property (nonatomic,strong) IBOutlet UILabel *decorationCompanyTitle;

@property (nonatomic, strong)IBOutlet UILabel* productTitle;
@property (nonatomic, strong)IBOutlet UILabel* timeTitleLabel;

@property (nonatomic, strong)IBOutlet UITextField* productTextField;
@property (nonatomic, strong)IBOutlet UITextField* timeTextField;

@property (strong, nonatomic) IBOutlet UIView *viewRoom;
@property (strong, nonatomic) IBOutlet UIView *viewPrincipal ;
@property (strong, nonatomic) IBOutlet UIView *viewInformation;
@property (strong, nonatomic) IBOutlet UIView *viewPrice;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UIButton *AddPassCardMan;

@property (nonatomic, strong) HNDeliverData* model;
@property (nonatomic, strong)IBOutlet UIButton* commitButton;
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
    self.timeTitleLabel.text = NSLocalizedString(@"起止日前", nil);
    
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
//    self.temporaryModel.complainObject = self.complaintObjectTF.text;
//    self.temporaryModel.complainType = self.complaintOCategoryTF.text;
//    self.temporaryModel.complainProblem = self.complaintContansTextView.text;
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.temporaryModel.declareId,@"body", self.temporaryModel.declareId,@"complainant",self.temporaryModel.declareId,@"complainantId",self.temporaryModel.declareId,@"complainfile",self.temporaryModel.complainObject,@"complainObject",self.temporaryModel.complainProblem,@"complainProblem",self.temporaryModel.complainType,@"complainType",self.temporaryModel.declareId,@"declareId",nil];
//    return dic;
    return nil;
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

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
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
