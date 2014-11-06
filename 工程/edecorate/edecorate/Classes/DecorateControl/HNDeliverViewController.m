//
//  HNDeliverViewController.m
//  edecorate
//
//  Created by hxx on 9/22/14.
//
//

#import "HNDeliverViewController.h"
#import "HNReportTableViewCell.h"
#import "HNDeliverDetailViewController.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNDeliverData.h"
#import "HNDeliverApplyViewController.h"
#import "HNRefundData.h"
#import "MJRefresh.h"

@interface HNDeliverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *dTableView;
@property (nonatomic, strong)NSMutableArray *deliverList;


@end

@implementation HNDeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Decorate Check", nil);
    self.dTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.dTableView.height = self.view.height-self.navigationController.navigationBar.height-20;
    self.dTableView.dataSource = self;
    self.dTableView.delegate = self;
    [self.view addSubview:self.dTableView];
    self.deliverList = [[NSMutableArray alloc] init];
    
    __weak typeof(self) wself = self;
    [self.dTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMyData];
    }];
    
    self.navigationItem.title = NSLocalizedString(@"Delivery&Installation", nil);
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_click"] style:UIBarButtonItemStylePlain target:self action:@selector(addButton_Clicked)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    //[self loadMyData];
}

-(void)addButton_Clicked
{
    HNDeliverApplyViewController* vc = [[HNDeliverApplyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadMyData];
}

-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid", nil];
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.install.list" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){

        [self performSelectorOnMainThread:@selector(didLoadMyData:) withObject:data waitUntilDone:YES];
    }];
}

-(void)didLoadMyData:(NSData*)data
{
    [self.dTableView headerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        [self.deliverList removeAllObjects];
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<total.intValue; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNDeliverData *tModel = [[HNDeliverData alloc] init];
                [tModel updateData:dicData];
                [self.deliverList addObject:tModel];
            }
            [self.dTableView reloadData];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.deliverList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"checkCell";
    HNReportTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    HNDeliverData *model = self.deliverList[indexPath.row];
    [cell setRoomName:model.roomnumber];
    //申请状态（0未审核，1已审核，-1审核未通过）
    switch (model.state.intValue) {
        case 0:
            [cell setStatus:@"未审核"];
            break;
        case 1:
            [cell setStatus:@"已审核"];
            break;
        case -1:
            [cell setStatus:@"审核未通过"];
            break;
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNDeliverDetailViewController *detail = [[HNDeliverDetailViewController alloc] initWithModel:self.deliverList[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
