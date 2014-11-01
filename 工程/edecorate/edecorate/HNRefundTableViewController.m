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

@interface HNRefundTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tTableView;
@property (nonatomic, strong)NSMutableArray *modelList;
@property (nonatomic, strong)HNRefundTableViewCell* refundTableViewCell;
@end


@implementation HNRefundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.delegate = self;
    self.tTableView.dataSource = self;
    [self.view addSubview:self.tTableView];
    
    
    self.navigationItem.title = NSLocalizedString(@"Deposit refund", nil);
    
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"新增", nil) style:UIBarButtonItemStylePlain target:self action:@selector(addButton_Clicked)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    //[self loadMyData];
}

-(void)addButton_Clicked
{
    {
        HNRefundApplyViewController* avc = [[HNRefundApplyViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
    }
}

-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid", nil];
    NSLog(@"%@",[HNLoginData shared].mshopid);
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.deposit.refund" Params:jsonStr]];
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
            NSNumber* total = [dic objectForKey:@"total"];
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<total.intValue; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNRefundData *tModel = [[HNRefundData alloc] init];
                [tModel updateData:dicData];
                [self.modelList addObject:tModel];

            }
            if (total.intValue){//之后需要替换成status
                [self.tTableView reloadData];
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
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.modelList = [[NSMutableArray alloc] init];
    [self loadMyData];
}
#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.modelList count];
}

- (HNRefundTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"refundCell";
    HNRefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        HNTemporaryModel *model =self.modelList[indexPath.row];
        cell = [[HNRefundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.refundTableViewCell = (HNRefundTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSInteger row = indexPath.row;
    HNTemporaryModel* model = self.modelList[row];
//    if(model.status==TemporaryStatusCustom)
//    {
//        HNRefundApplyViewController* avc = [[HNRefundApplyViewController alloc]initWithModel:model];
//        [self.navigationController pushViewController:avc animated:YES];
//    }
//    else
    {
        HNRefundDetailViewController* dac = [[HNRefundDetailViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:dac animated:YES];
    }
    
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
