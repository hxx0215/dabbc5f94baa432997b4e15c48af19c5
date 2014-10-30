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
    
    self.navigationItem.title=@"办理出入证";
    //[self GetPassList:@"admin" byPage:@"1" AndRow:@"8"];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"新增", nil) style:UIBarButtonItemStylePlain target:self action:@selector(addButton_Clicked)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            //NSLog(@"%@",retJson);
            NSDictionary* dic = [retJson objectFromJSONString];
            NSNumber* total = [dic objectForKey:@"total"];
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<total.intValue; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNPassData *tModel = [[HNPassData alloc] init];
                [tModel updateData:dicData];
                [self.modelList addObject:tModel];
            }
            if (total.intValue){//之后需要替换成status
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
        
    }];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.modelList = [[NSMutableArray alloc] init];
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
        HNPassData *model =self.modelList[indexPath.row];
        cell = [[HNOfficePassedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
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
