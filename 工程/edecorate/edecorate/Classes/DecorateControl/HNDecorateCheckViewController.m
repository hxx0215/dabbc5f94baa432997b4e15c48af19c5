//
//  HNDecorateCheckViewController.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNDecorateCheckViewController.h"
#import "HNCheckTableViewCell.h"
//#import "HNCheckDetailViewController.h"
#import "HNLoginData.h"
#import "MJRefresh.h"
#import "HNCheckViewController.h"
#import "MBProgressHUD.h"
#import "HNNewCheckViewController.h"

@interface HNCheckModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *checkSchedule;
@property (nonatomic, strong)NSString *checkStage;
@property (nonatomic, strong)NSString *checkid;
@property (nonatomic, strong)NSString *deployId;
@property (nonatomic, strong)NSString *manageAssessor;
@property (nonatomic, strong)NSString *ownerAssessor;
@end
@implementation HNCheckModel
@end

@interface HNDecorateCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *cTableView;
@property (nonatomic, strong)NSMutableArray *checkList;
@property (nonatomic, strong)NSDictionary *stageMap;
@property (nonatomic, strong)UIBarButtonItem *createButton;
@end

@implementation HNDecorateCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"装修验收", nil);
    self.cTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.cTableView.dataSource = self;
    self.cTableView.delegate = self;
    [self.view addSubview:self.cTableView];
    typeof(self) __weak weakSelf = self;
    [self.cTableView addHeaderWithCallback:^{
       typeof(self) strongSelf = weakSelf;
        [strongSelf refreshData];
    }];
    self.checkList = [[NSMutableArray alloc] init];
    self.stageMap = @{@"-1": NSLocalizedString(@"验收不通过", nil),@"0": NSLocalizedString(@"等待验收", nil), @"1": NSLocalizedString(@"验收通过", nil)};
    [self initNaviButton];
    
//    HNCheckModel *model = [[HNCheckModel alloc] init];
//    model.roomName =@"小区名房间号";
//    model.checkSchedule = @"验收进度";
//    model.checkStage = @"验收阶段";
//    
//    [self.checkList addObject:model];
}
- (void)initNaviButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add_click.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(createNewCheck:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.createButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = self.createButton;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    self.cTableView.frame = self.view.bounds;
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createNewCheck:(id)sender{
    HNNewCheckViewController *vc = [[HNNewCheckViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.checkList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"checkCell";
    HNCheckTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    HNCheckModel *model = self.checkList[indexPath.row];
    cell.roomName.text = model.roomName;
    cell.checkSchedule.text = model.checkSchedule;
    cell.checkStage.text = self.stageMap[model.checkStage];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    HNCheckDetailViewController *checkDetail = [[HNCheckDetailViewController alloc] init];
//    [self.navigationController pushViewController:checkDetail animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSDictionary *sendDic = @{@"checkid": [self.checkList[indexPath.row] checkid]};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.acceptance.stepinfo" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0 != count){
                NSArray *dataArr = [retDic objectForKey:@"data"];
                HNCheckViewController *vc = [[HNCheckViewController alloc] init];
                vc.contentArr = [dataArr[0] objectForKey:@"ItemType"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:YES];
                });
            }
            else{
                [self showNoData];
            }
        }
        else{
            [self showNoNet];
        }
    }];
}

- (void)refreshData{
    NSDictionary *sendDic = @{@"mshopid": [HNLoginData shared].mshopid};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.acceptance.list" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self.cTableView headerEndRefreshing];
        [self loadDataComplete];
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0 != count){
                NSArray *dataArr = [retDic objectForKey:@"data"];
                [self.checkList removeAllObjects];
                for (int i = 0; i<count ;i ++){
                    HNCheckModel *model = [[HNCheckModel alloc] init];
                    model.roomName = [dataArr[i] objectForKey:@"room"];
                    model.checkid = [dataArr[i] objectForKey:@"checkid"];
                    model.checkSchedule = [dataArr[i] objectForKey:@"processname"];
                    model.deployId = [dataArr[i] objectForKey:@"depolyId"];
                    model.ownerAssessor = [dataArr[i] objectForKey:@"ownerAssessor"];
                    model.manageAssessor = [dataArr[i] objectForKey:@"manageAssessor"];
                    model.checkStage = [dataArr[i] objectForKey:@"state"];
                    [self.checkList addObject:model];
                }
                [self.cTableView reloadData];
            }
            else{
                [self showNoData];
            }
        }
        else{
            [self showNoNet];
        }
    }];
}

- (void)showNoNet{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    });
    
}

- (void)showNoData{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)loadDataComplete{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
