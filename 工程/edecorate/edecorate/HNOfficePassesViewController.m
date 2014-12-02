//
//  HNOfficePassesViewController.m
//  edecorate 出入证申请列表
//
//  Created by 熊彬 on 14-9-19.
//
//

#import "HNOfficePassesViewController.h"
#import "HNOfficePassedTableViewCell.h"
#import "HNOfficePassesDetailsViewController.h"
#import "HNOfficePassesApplyViewController.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "NSString+Crypt.h"
#import "HNLoginData.h"
#import "HNPassData.h"
#import "HNRefundData.h"
#import "MJRefresh.h"

//@interface HNOfficePassModel : NSObject
//@property (nonatomic, strong)NSString *roomName;
//@property (nonatomic, strong)NSString *status;
//@end
//@implementation HNOfficePassModel
//@end
@interface HNGetPassListModel: NSObject
@property (nonatomic, strong)NSString *shopid;
//@property (nonatomic, strong)long *pageindex;
//@property (nonatomic, strong)NSInteger *pagesize;
@end
@implementation HNGetPassListModel
@end


@interface HNOfficePassesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tTableView;
@property (nonatomic,strong)NSMutableArray *modelList;
@property (nonatomic,strong)HNOfficePassedTableViewCell *passTableViewCell;

@end

@implementation HNOfficePassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tTableView=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.delegate=self;
    self.tTableView.dataSource=self;
    [self.view addSubview:self.tTableView];
    self.tTableView.height = self.view.height-self.navigationController.navigationBar.height-20;
    self.modelList = [[NSMutableArray alloc] init];
    
    __weak typeof(self) wself = self;
    [self.tTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMyData];
    }];
    
    self.navigationItem.title=@"办理出入证";
    //[self GetPassList:@"admin" byPage:@"1" AndRow:@"8"];

    [self initNaviButton];
    
}
- (void)initNaviButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add_click.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(addButton_Clicked) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(void)addButton_Clicked
{
    HNOfficePassesApplyViewController* officePasseesApply=[[HNOfficePassesApplyViewController alloc]init];
    [self.navigationController pushViewController:officePasseesApply animated:YES];
}


-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid", nil];
    //NSLog(@"%@",[HNLoginData shared].mshopid);
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.pass.list" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){

        [self performSelectorOnMainThread:@selector(didLoadMyData:) withObject:data waitUntilDone:YES];
    }];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
-(void)didLoadMyData:(NSData*)data
{
    [self.tTableView headerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        [self.modelList removeAllObjects];
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (!retStr){
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        //NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<total.intValue; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNPassData *tModel = [[HNPassData alloc] init];
                [tModel updateData:dicData];
                [self.modelList addObject:tModel];
            }
            [self.tTableView reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Fail", nil) message:NSLocalizedString(@"Please input correct username and password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadMyData];
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69.0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.modelList count];
}



-(HNOfficePassedTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"refundCell";
    HNOfficePassedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[HNOfficePassedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNPassData *model =self.modelList[indexPath.row];
    [cell setRoomName:model.roomnumber];
    [cell setStatus:model.assessorState];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNPassData* model = self.modelList[indexPath.row];
//    if([model.CARDId isEqualToString:@"24"])
//    {
//        HNOfficePassesApplyViewController* officePasseesApply=[[HNOfficePassesApplyViewController alloc] initWithModel:model];
//        [self.navigationController pushViewController:officePasseesApply animated:YES];
//    }
 //   else
    {
        HNOfficePassesDetailsViewController *officeDetails=[[HNOfficePassesDetailsViewController alloc]  initWithModel:model];
        [self.navigationController pushViewController:officeDetails animated:YES];
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
