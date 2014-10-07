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

//@interface HNOfficePassModel : NSObject
//@property (nonatomic, strong)NSString *roomName;
//@property (nonatomic, strong)NSString *status;
//@end
//@implementation HNOfficePassModel
//@end


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
    [self GetPassList:@"admin"];
   // self.modelList=[[NSMutableArray alloc] init];
    
//    HNTemporaryModel *tModel=[[HNTemporaryModel alloc] init];
//    tModel.roomName=@"施工房号：大富大贵花园A座001";
//    tModel.status = TemporaryStatusCustom;
//    [self.modelList addObject:tModel];
//    
//    HNTemporaryModel *TModel2=[[HNTemporaryModel alloc] init];
//    TModel2.roomName=@"施工房号：大富大贵花园A座002";
//    TModel2.status=TemporaryStatusCustom;
//    [self.modelList addObject:TModel2];
}

- (NSDictionary *)encodeWithPassModel:(NSString *)shopid{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:shopid,@"mshopid", nil];
    return dic;
}
//获取出入证列表:调用接口
-(void)GetPassList:(NSString *)myshopid{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //拼传输参数(json)
    NSString *RequestJsonStr=[[self encodeWithPassModel:myshopid] JSONString];
    request.URL=[NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.pass.list" Params:RequestJsonStr]];
    NSString *contentType=@"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    //开始异步调用
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (data) {
            NSString *returnStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *returnJson=[NSString decodeFromPercentEscapeString:[returnStr decryptWithDES]];
            if(YES)
            {
                //查询成功
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"测试提示" message:returnJson delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
                [alert show];
            }else
            {
                //查询失败
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"错误1", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
                [alert show];
            }
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"请检查网络是否连接", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert show];
        }
    }];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.passTableViewCell)
    {
        [self.passTableViewCell updateMyCell];
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.modelList count];
}



-(HNOfficePassedTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"refundCell";
    HNOfficePassedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        HNTemporaryModel *model =self.modelList[indexPath.row];
        cell = [[HNOfficePassedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNTemporaryModel* model = self.modelList[indexPath.row];
    if(model.status==TemporaryStatusCustom)
    {
        HNOfficePassesApplyViewController* officePasseesApply=[[HNOfficePassesApplyViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:officePasseesApply animated:YES];
    }else{
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
