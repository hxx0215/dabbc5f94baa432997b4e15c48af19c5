//
//  HNRefundTableViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import "HNRefundTableViewController.h"
#import "HNRefundTableViewCell.h"
#import "HNRefundApplyViewController.h"
#import "HNRefundDetailViewController.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "NSString+Crypt.h"
#import "HNLoginData.h"
#import "HNRefundData.h"
#import "MJRefresh.h"


@interface HNRefundSendModel : NSObject//列表和详细通用
@property (nonatomic, strong)NSString *mshopid;
@property (nonatomic, strong)NSString *declareId;
@end
@implementation HNRefundSendModel
@end

@interface HNRefundTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *rTableView;
@property (nonatomic, strong)NSMutableArray *refundList;
@property (nonatomic, strong)NSDictionary *statusMap;
@property (nonatomic, strong)HNRefundModel *currentModel;
@end


@implementation HNRefundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.rTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.rTableView.height = self.view.height-self.navigationController.navigationBar.height-20;
    self.rTableView.delegate = self;
    self.rTableView.dataSource = self;
    [self.view addSubview:self.rTableView];
    self.refundList = [[NSMutableArray alloc] init];
    __weak typeof(self) wself = self;
    [self.rTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        [sself refreshData];
    }];
    
    self.statusMap = @{@"0": @"审核进度:未审核",@"1": @"审核进度:已审核",@"-1":@"审核进度:审核未通过"};
    
    
    self.navigationItem.title = NSLocalizedString(@"Deposit refund", nil);
    
    
//    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"新增", nil) style:UIBarButtonItemStylePlain target:self action:@selector(addButton_Clicked)];
//    self.navigationItem.rightBarButtonItem = barButtonItem;
    //[self loadMyData];
}

//-(void)addButton_Clicked
//{
//    {
//        HNRefundApplyViewController* avc = [[HNRefundApplyViewController alloc]init];
//        [self.navigationController pushViewController:avc animated:YES];
//    }
//}
//
-(void)loadMyData:(HNRefundModel*)model
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:model.declareId,@"declareid", nil];
    self.currentModel = model;
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.deposit.refund" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didLoadMyData:) withObject:data waitUntilDone:YES];
    }];
}

-(void)didLoadMyData:(NSData*)data
{
    assert(self.currentModel);
    [self.rTableView headerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (!retStr){
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue>=0){//之后需要替换成status
            
            NSArray* array = [dic objectForKey:@"data"];
            NSDictionary *dicData = [array objectAtIndex:0];
            HNRefundData *tModel = [[HNRefundData alloc] init];
            [tModel updateData:dicData];
            tModel.refundModel = self.currentModel;
            
            HNRefundApplyViewController* dac = [[HNRefundApplyViewController alloc]initWithModel:tModel];
            [self.navigationController pushViewController:dac animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Load Data Fail", nil) message:NSLocalizedString(@"NO data", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
    self.currentModel = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.modelList = [[NSMutableArray alloc] init];
    [self refreshData];
}

- (NSDictionary *)encodeDetailModel:(HNRefundSendModel *)model{
    return @{@"mshopid": model.mshopid,@"declareid":model.declareId};
}

- (NSDictionary *)encodeSendModel:(HNRefundSendModel*)model{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.mshopid,@"mshopid", nil];
    return dic;
}

- (void)refreshData{
    HNRefundSendModel *model = [[HNRefundSendModel alloc] init];
    model.mshopid = [HNLoginData shared].mshopid;
    NSString *sendJson = [[self encodeSendModel:model] JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.decoration.declare" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
 
        [self performSelectorOnMainThread:@selector(didrefreshData:) withObject:data waitUntilDone:YES];
    }];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
-(void)didrefreshData:(NSData*)data
{
    [self.rTableView headerEndRefreshing];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (!retStr){
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSDictionary *retDic = [retJson objectFromJSONString];
        NSInteger count = [[retDic objectForKey:@"total"] integerValue];
        if (0!=count)
        {
            NSArray *dataArr = [retDic objectForKey:@"data"];
            [self.refundList removeAllObjects];
            for (int i=0; i<count; i++) {
                HNRefundModel *model = [[HNRefundModel alloc] init];
                model.status = self.statusMap[[dataArr[i] objectForKey:@"assessorstate"]];
                model.roomName = [NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"roomnumber"]];
                model.declareId = [dataArr[i] objectForKey:@"declareId"];
                [self.refundList addObject:model];
            }
            [self.rTableView reloadData];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.refundList count];
}

- (HNRefundTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"refundCell";
    HNRefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNRefundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNRefundModel *model =self.refundList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    HNRefundModel* model = self.refundList[row];
    [self loadMyData:model];
    
}

- (void)didReceiveMemoryWarning
{
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
