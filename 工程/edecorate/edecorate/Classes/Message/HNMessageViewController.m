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

@property (nonatomic)BOOL isfirst;
@property (nonatomic) NSInteger pages;
@property (nonatomic) NSInteger lastTotal;
@end

@implementation HNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    self.title = NSLocalizedString(@"Message", nil);
    [self initTableView];
    
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
        sself.pages = 0;
        sself.lastTotal = 8;
        [sself loadMyData];
    }];
    [self.mTableView addFooterWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMore];
    }];
    self.isfirst = YES;
    self.pages = 0;
    self.lastTotal = 8;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNMessageTableViewCell class]) bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"messageCell"];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mTableView.frame = self.view.bounds;
    self.mTableView.height = self.view.bounds.size.height-self.navigationController.navigationBar.height;
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
            [self.mTableView footerEndRefreshing];
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
    NSLog(@"%@",[HNLoginData shared].mshopid);
    NSString *jsonStr = [dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.shop.message" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didloadMyData:) withObject:data waitUntilDone:YES];
    }];
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)didloadMyData:(NSData *)data
{
    [self.mTableView headerEndRefreshing];
    [self.mTableView footerEndRefreshing];
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
            [self.mList removeAllObjects];
        }
        self.lastTotal = total.intValue;
        
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
    if (messageModel.isread.intValue) {
        [cell.imageViewRead setImage:nil];
    }
    else
    {
        [cell.imageViewRead setImage:[UIImage imageNamed:@"unsubmit"]];
    }
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
