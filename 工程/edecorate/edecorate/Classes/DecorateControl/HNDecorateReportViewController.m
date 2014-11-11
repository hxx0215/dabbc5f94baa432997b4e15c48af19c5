//
//  HNDecorateReportViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNDecorateReportViewController.h"
#import "HNReportTableViewCell.h"
#import "HNNewReportViewController.h"
#import "MJRefresh.h"
#import "HNLoginData.h"
#import "MBProgressHUD.h"
#import "HNConstructViewController.h"


@interface HNReportModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, assign)HNConstructType constructType;
@property (nonatomic, strong)NSString *declareId;
@end
@implementation HNReportModel
@end
@interface HNReportSendModel : NSObject//列表和详细通用
@property (nonatomic, strong)NSString *mshopid;
@property (nonatomic, strong)NSString *declareId;
@end
@implementation HNReportSendModel
@end

@interface HNDecorateReportViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong)UITableView *rTableView;
@property (nonatomic, strong)NSMutableArray *reportList;
@property (nonatomic, strong)UIBarButtonItem *reportButton;
@property (nonatomic, strong)NSDictionary *statusMap;
@end

@implementation HNDecorateReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Decorate Construction", nil);
    self.rTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.rTableView.delegate = self;
    self.rTableView.dataSource = self;
    [self.view addSubview:self.rTableView];
    __weak typeof(self) wself = self;
    [self.rTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        [sself refreshData];
    }];
    [self initNaviButton];
    self.statusMap = @{@"0": @"审核进度:未审核",@"1": @"审核进度:已审核",@"-1":@"审核进度:审核未通过"};
    
    self.reportList = [[NSMutableArray alloc] init];
//    HNReportModel *tModel = [[HNReportModel alloc] init];
//    tModel.roomName = @"施工房号：XXXX";
//    tModel.status = @"审核进度:审核中";
//    tModel.constructType = kCompanyNew;
//    [self.reportList addObject:tModel];
//    
//    HNReportModel *modelComDetail = [[HNReportModel alloc] init];
//    modelComDetail.roomName = @"施工房号：";
//    modelComDetail.status =@"审核进度:已通过";
//    modelComDetail.constructType = kCompanyDetail;
//    [self.reportList addObject:modelComDetail];
//    
//    HNReportModel *modelOwnNew = [[HNReportModel alloc]init];
//    modelOwnNew.roomName =@"施工房号：业主自装";
//    modelOwnNew.status = @"审核进度：审核中";
//    modelOwnNew.constructType = kPersonalNew;
//    [self.reportList addObject:modelOwnNew];
//    
//    HNReportModel *modelOwnDetail = [[HNReportModel alloc] init];
//    modelOwnDetail.roomName = @"施工房号：业主自装";
//    modelOwnDetail.status = @"审核进度：已通过";
//    modelOwnDetail.constructType = kPersonalDetail;
//    [self.reportList addObject:modelOwnDetail];
}
- (void)initNaviButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add_click.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(reportButton_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rTableView headerBeginRefreshing];
}
- (void)reportButton_Clicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"请输入要承接的保健项目编号", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
# pragma mark - tableViewDelegate & tableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.reportList count];
}

- (HNReportTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"reportCell";
    HNReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNReportModel *model =self.reportList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    HNReportSendModel *sendmodel = [[HNReportSendModel alloc] init];
    sendmodel.mshopid = [HNLoginData shared].mshopid;
    sendmodel.declareId = [self.reportList[indexPath.row] declareId];
    NSString *sendJson = [[self encodeDetailModel:sendmodel] JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.decoraton.declaredetails" Params:sendJson]];
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
            if (count != 0){
                NSArray *dataArr = [retDic objectForKey:@"data"];
                HNConstructViewController *vc = [[HNConstructViewController alloc] init];
                NSInteger type = [[dataArr[0] objectForKey:@"type"] integerValue];
                if (type == 0)
                    vc.constructType = kPersonalDetail;
                else
                    vc.constructType = kCompanyDetail;
                vc.roomNo = [dataArr[0] objectForKey:@"roomNumber"];
                vc.ownerName = [dataArr[0] objectForKey:@"ownername"];
                vc.ownerMobile = [dataArr[0] objectForKey:@"ownerphone"];
                vc.declareid = [dataArr[0] objectForKey:@"declareId"];
                [vc.chart setObject:[dataArr[0] objectForKey:kOriginalSChart] forKey:kOriginalSChart];
                [vc.chart setObject:[dataArr[0] objectForKey:kfloorplan] forKey:kfloorplan];
                [vc.chart setObject:[dataArr[0] objectForKey:kwallRemould] forKey:kwallRemould];
                [vc.chart setObject:[dataArr[0] objectForKey:kceilingPlan] forKey:kceilingPlan];
                [vc.chart setObject:[dataArr[0] objectForKey:kWaterwayPlan] forKey:kWaterwayPlan];
                [vc.chart setObject:[dataArr[0] objectForKey:kBlockDiagram] forKey:kBlockDiagram];
                vc.shopInfo = [dataArr[0] objectForKey:kshopInfo];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:vc animated:YES];
                });
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
                
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
            });
        }
    }];

}
- (NSDictionary *)encodeDetailModel:(HNReportSendModel *)model{
    return @{@"mshopid": model.mshopid,@"declareid":model.declareId};
}
- (NSDictionary *)encodeSendModel:(HNReportSendModel*)model{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:model.mshopid,@"mshopid", nil];
    return dic;
}

- (void)refreshData{
    HNReportSendModel *model = [[HNReportSendModel alloc] init];
    model.mshopid = [HNLoginData shared].mshopid;
    NSString *sendJson = [[self encodeSendModel:model] JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.decoration.declare" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self.rTableView headerEndRefreshing];
        if (data)
        {
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0!=count)
            {
                NSArray *dataArr = [retDic objectForKey:@"data"];
                [self.reportList removeAllObjects];
                for (int i=0; i<count; i++) {
                    HNReportModel *model = [[HNReportModel alloc] init];
                    model.status = self.statusMap[[dataArr[i] objectForKey:@"assessorstate"]];
                    model.roomName = [NSString stringWithFormat:@"%@",[dataArr[i] objectForKey:@"roomnumber"]];
                    model.declareId = [dataArr[i] objectForKey:@"declareId"];
                    [self.reportList addObject:model];
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
    }];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (0==buttonIndex)
        return;
    UITextField *tf=[alertView textFieldAtIndex:0];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    if (buttonIndex == 1){
        NSDictionary *dic = @{@"declareid": @"10006"};//tf.text};
        NSString *sendJson = [dic JSONString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.decorate.undertake" Params:sendJson]];
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
                if (count != 0){
                    NSArray *dataArr = [retDic objectForKey:@"data"];
                    NSInteger state = [[dataArr[0] objectForKey:@"state"] integerValue];
                    if (1==state){
                        HNNewReportViewController *vc = [[HNNewReportViewController alloc] init];
                        NSInteger type = [[dataArr[0] objectForKey:@"type"] integerValue];
                        vc.constructType = type;
                        vc.declareId = [NSString stringWithFormat:@"%@",[dataArr[0] objectForKey:@"declareId"]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:vc animated:YES];
                        });
                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[dataArr[0] objectForKey:@"msg"] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [alert show];
                        });
                    }
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert show];
                    });
                }
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
            }
        }];
    }
}
@end
