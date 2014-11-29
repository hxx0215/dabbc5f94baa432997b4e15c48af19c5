//
//  HNMessageViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNMessageViewController.h"
#import "HNMessageModel.h"
#import "HNMessageTableViewCell.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "NSString+Crypt.h"
#import "HNLoginData.h"
#import "MJRefresh.h"
#import "HNMessageDetailViewController.h"

@interface HNMessageViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic, strong)UITableView *mTableView;
@property (nonatomic, strong)NSMutableArray *mList;
@end

@implementation HNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    self.title = NSLocalizedString(@"Message", nil);
    [self initTableView];
    
//    self.mList = [[NSMutableArray alloc] init];
//    HNMessageModel *m1= [[HNMessageModel alloc] init];
//    m1.title = @"装修违规纠正通知";
//    m1.messgae = @"  您在更美（毫州）华佗国际中药城1栋18号铺进行装..";
//    m1.date = @"2014/9/17 14:30";
//    [self.mList addObject:m1];
//    HNMessageModel *m2= [[HNMessageModel alloc] init];
//    m2.title = @"处罚单";
//    m2.messgae = @"  您好！非常感谢阁下一直以来对我公司工作的支持和配合..";
//    m2.date = @"2014/9/18 10:30";
//    [self.mList addObject:m2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTableView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.mTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.height = self.view.height - self.navigationController.navigationBar.height-20;
    [self.view addSubview:self.mTableView];
    self.mList = [[NSMutableArray alloc] init];
    
    __weak typeof(self) wself = self;
    [self.mTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMyData];
    }];

    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNMessageTableViewCell class]) bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"messageCell"];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mTableView.frame = self.view.bounds;
    self.mTableView.height = self.view.bounds.size.height-self.navigationController.navigationBar.height;
    [self loadMyData];
}


-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid", nil];
    NSLog(@"%@",[HNLoginData shared].mshopid);
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.shop.message" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didloadMyData:) withObject:data waitUntilDone:YES];
    }];
}

- (void)didloadMyData:(NSData *)data
{
    [self.mTableView headerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (data)
    {
        [self.mList removeAllObjects];
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<total.intValue; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                HNMessageModel *tModel = [[HNMessageModel alloc] init];
                [tModel updateData:dicData];
                [self.mList addObject:tModel];
                
            }
            [self.mTableView reloadData];
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

#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNMessageTableViewCell *cell;
    static NSString *reuseIdentify = @"messageCell";
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (!cell){
        cell = [[HNMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentify];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    HNMessageModel *messageModel = [self.mList objectAtIndex:indexPath.row];
    cell.labelTitle.text = messageModel.title;
    cell.labelMessage.text = messageModel.message;
    cell.labelDate.text = messageModel.addtime;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger row = indexPath.row;
    HNMessageModel* model = self.mList[row];
    HNMessageDetailViewController *vc = [[HNMessageDetailViewController alloc]init];
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}

@end
