//
//  HNTemporaryFireViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import "HNTemporaryFireViewController.h"
#import "HNTemporaryTableViewCell.h"
#import "HNTemporaryApplyViewController.h"
#import "HNTemporaryDetailsViewController.h"
#import "NSString+Crypt.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"
#import "HNRefundData.h"
#import "MJRefresh.h"

@interface HNTemporaryFireViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tTableView;
@property (nonatomic, strong)HNTemporaryData *model;
@property (nonatomic)HNTemporaryType temporaryType;
@property (nonatomic, strong)HNTemporaryTableViewCell* temporaryTableViewCell;
@property (nonatomic)BOOL isfirst;
@property (nonatomic) NSInteger pages;
@property (nonatomic) NSInteger lastTotal;
@end

@implementation HNTemporaryFireViewController

-(id)initWithTemporaryType:(HNTemporaryType)type
{
    self = [super init];
    self.temporaryType = type;
    return self;
}

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
    self.tTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.height = self.view.height-self.navigationController.navigationBar.height-20;
    self.tTableView.delegate = self;
    self.tTableView.dataSource = self;
    [self.view addSubview:self.tTableView];
    
    __weak typeof(self) wself = self;
    [self.tTableView addHeaderWithCallback:^{
        typeof(self) sself = wself;
        sself.pages = 0;
        sself.lastTotal = 8;
        switch (sself.temporaryType) {
            case FIRE:
                [sself loadFire];
                break;
            case POWER:
                [sself loadPower];
                break;
                
            default:
                break;
        }
    }];
    
    [self.tTableView addFooterWithCallback:^{
        typeof(self) sself = wself;
        [sself loadMore];
    }];

    

    self.navigationItem.title = [self getTitleString];
    [self initNaviButton];
    

    self.model = [[HNTemporaryData alloc] init];
    self.model.mshopid = [HNLoginData shared].mshopid;
    self.model.type = self.temporaryType;
//    switch (self.temporaryType) {
//        case FIRE:
//            [self loadFire];
//            break;
//        case POWER:
//            [self loadPower];
//            break;
//            
//        default:
//            break;
//    }
    self.isfirst = TRUE;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.isfirst) {
        self.pages = 0;
        self.lastTotal = 8;
        switch (self.temporaryType) {
            case FIRE:
                [self loadFire];
                break;
            case POWER:
                [self loadPower];
                break;
                
            default:
                break;
        }
        
        self.isfirst = NO;
    }
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
    HNTemporaryApplyViewController* tac = [[HNTemporaryApplyViewController alloc]initWithType:self.temporaryType];
    [self.navigationController pushViewController:tac animated:YES];
}

-(void)loadMore
{
    if (self.lastTotal!=8) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tTableView footerEndRefreshing];
        });
        return ;//已到最后。返回
    }
    self.pages ++;
    switch (self.temporaryType) {
        case FIRE:
            [self loadFire];
            break;
        case POWER:
            [self loadPower];
            break;
            
        default:
            break;
    }
}

-(void)loadFire
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithTemporaryModel:self.model.mshopid] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.temporary.fire" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){

        [self performSelectorOnMainThread:@selector(didLoadFire:) withObject:data waitUntilDone:YES];
    }];
}

-(void)didLoadFire:(NSData *)data
{
    [self.tTableView headerEndRefreshing];
    [self.tTableView footerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (!retStr){
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSLog(@"%@",self.model.error);
        if (self.pages==0) {
            [self.model.modelList removeAllObjects];
        }
        [self.model updateData:dic];
        self.lastTotal = self.model.total.intValue;
        if (self.model.total.intValue){//之后需要替换成status
            
            [self.tTableView reloadData];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

-(void)loadPower
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *jsonStr = [[self encodeWithTemporaryModel:self.model.mshopid] JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.temporary.electro" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(didLoadPower:) withObject:data waitUntilDone:YES];
        
    }];
    
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}

-(void)didLoadPower:(NSData *)data
{
    [self.tTableView headerEndRefreshing];
    [self.tTableView footerEndRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (!retStr){
            [self showBadServer];
            return ;
        }
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        if (self.pages==0) {
            [self.model.modelList removeAllObjects];
        }
        [self.model updateData:dic];
        self.lastTotal = self.model.total.intValue;
        if (self.model.total.intValue){//之后需要替换成status
            [self.tTableView reloadData];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

- (NSDictionary *)encodeWithTemporaryModel:(NSString *)shopid{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:shopid,@"mshopid",@"8",@"pagesize",[NSString stringWithFormat:@"%ld",(self.pages+1)],@"pageindex", nil];
    return dic;
}

-(NSString*)getTitleString
{
    if (self.temporaryType == FIRE) {
        return NSLocalizedString(@"Temporary fire", nil);
    }
    else if(self.temporaryType == POWER)
    {
        return NSLocalizedString(@"Temporary power", nil);
    }
    return @"";
}



#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model.modelList count];
}

- (HNTemporaryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"temporaryCell";
    HNTemporaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        
        cell = [[HNTemporaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNTemporaryModel *model =self.model.modelList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.temporaryTableViewCell = (HNTemporaryTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSInteger row = indexPath.row;
    HNTemporaryModel* model = self.model.modelList[row];
//    if(model.status==TemporaryStatusCustom)
//    {
//        
//    }
//    else
    {
        HNTemporaryDetailsViewController* tdc = [[HNTemporaryDetailsViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:tdc animated:YES];
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
