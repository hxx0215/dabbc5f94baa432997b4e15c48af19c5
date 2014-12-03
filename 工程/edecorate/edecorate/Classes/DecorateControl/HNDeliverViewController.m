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
#import "HNOfficePassedTableViewCell.h"

@interface HNDeliverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *dTableView;
@property (nonatomic, strong)NSMutableArray *deliverList;

@property (nonatomic)BOOL isfirst;
@property (nonatomic) NSInteger pages;
@property (nonatomic) NSInteger lastTotal;
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
        sself.pages = 0;
        sself.lastTotal = 8;
        [sself loadMyData];
    }];
    [self.dTableView addFooterWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMore];
    }];
    self.isfirst = YES;
    self.pages = 0;
    self.lastTotal = 8;
    
    self.navigationItem.title = NSLocalizedString(@"Delivery&Installation", nil);
    

    self.isfirst = YES;
    [self initNaviButton];
    //[self loadMyData];
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
    HNDeliverApplyViewController* vc = [[HNDeliverApplyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isfirst) {
        self.pages = 0;
        self.lastTotal = 8;
        [self loadMyData];
        self.isfirst = NO;
    }
    
}

-(void)loadMore
{
    if (self.lastTotal!=8) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dTableView footerEndRefreshing];
        });
        return ;//已到最后。返回
    }
    self.pages ++;
    [self loadMyData];
}

-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid",@"8",@"pagesize",[NSString stringWithFormat:@"%ld",(self.pages+1)],@"pageindex", nil];
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.install.list" Params:jsonStr]];
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
    [self.dTableView headerEndRefreshing];
    [self.dTableView footerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr){
            [self showBadServer];
            return;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        if (self.pages==0) {
            [self.deliverList removeAllObjects];
        }
        self.lastTotal = total.intValue;
        
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
    static NSString *identify = @"fficePassedCell";
    HNOfficePassedTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNOfficePassedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    HNDeliverData *model = self.deliverList[indexPath.row];
    [cell setRoomName:model.roomnumber];
    //申请状态（0未审核，1已审核，-1审核未通过）
    [cell setStatus:model.state];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNDeliverDetailViewController *detail = [[HNDeliverDetailViewController alloc] initWithModel:self.deliverList[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
