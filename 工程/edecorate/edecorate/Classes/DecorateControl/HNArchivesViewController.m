//
//  HNArchivesViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-11-14.
//
//

#import "HNArchivesViewController.h"
#import "HNArchivesTableViewCell.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "NSString+Crypt.h"
#import "HNLoginData.h"
#import "MJRefresh.h"
#import "HNDecorateData.h"
#import "HNArchivesListViewController.h"

@interface HNArchivesDecorateModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *declareId;
@end
@implementation HNArchivesDecorateModel
@end

@interface HNArchivesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tTableView;
@property (nonatomic, strong)NSMutableArray *modelList;
@property (nonatomic)BOOL isFirst;
@end

@implementation HNArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.delegate = self;
    self.tTableView.dataSource = self;
    self.tTableView.height = self.view.height - self.navigationController.navigationBar.height-20;
    [self.view addSubview:self.tTableView];
    self.modelList = [[NSMutableArray alloc] init];
    
    __weak typeof(self) wself = self;
    [self.tTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMyData];
    }];
    self.isFirst = YES;
    self.navigationItem.title = NSLocalizedString(@"Archives", nil);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isFirst) {
        [self loadMyData];
        self.isFirst = NO;
    }
    
    
}
#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.modelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"ArchivesCell";
    HNArchivesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[HNArchivesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNArchivesDecorateModel *model =self.modelList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    HNArchivesDecorateModel* model = self.modelList[row];
    {
        HNArchivesListViewController* dac = [[HNArchivesListViewController alloc]init];
        dac.dID = model.declareId;
        dac.room = model.roomName;
        [self.navigationController pushViewController:dac animated:YES];
    }
    
}

#pragma mark data
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(doDecorateData:) withObject:data waitUntilDone:YES];
    }];
}

- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)doDecorateData:(NSData *)data
{
    [self.tTableView headerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!retStr)
        {
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSInteger count = [[dic objectForKey:@"total"] integerValue];
        if (0!=count)
        {
            NSArray *dataArr = [dic objectForKey:@"data"];
            [self.modelList removeAllObjects];
            for (int i=0; i<count; i++) {
                HNArchivesDecorateModel *model = [[HNArchivesDecorateModel alloc] init];
                model.status = [dataArr[i] objectForKey:@"assessorstate"];
                model.roomName = [NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"roomnumber"]];
                model.declareId = [dataArr[i] objectForKey:@"declareId"];
                [self.modelList addObject:model];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
