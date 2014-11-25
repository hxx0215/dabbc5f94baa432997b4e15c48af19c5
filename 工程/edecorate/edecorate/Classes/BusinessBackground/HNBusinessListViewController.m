//
//  HNBusinessListViewController.m
//  edecorate
//
//  Created by hxx on 9/27/14.
//
//

#import "HNBusinessListViewController.h"
#import "MJRefresh.h"
#import "UIView+AHKit.h"
#import "HNLoginData.h"

#import "HNGoodsTableViewCell.h"
#import "HNGoodsViewController.h"
#import "HNGoodsHeaderView.h"
#import "HNGoodsCategoriesViewController.h"

#import "HNReturnsHeaderView.h"
#import "HNReimburseViewController.h"
#import "HNReturnsTableViewCell.h"

#import "HNCommentsTableViewCell.h"
#import "HNCommentsHeaderView.h"
#import "HNCommentsDetailViewController.h"

#import "HNOrderHeaderView.h"
#import "HNOrderTableViewCell.h"
#import "HNOrderViewController.h"

@interface HNBusinessListViewController ()<UITableViewDelegate,UITableViewDataSource,HNGoodsCategoriesDelegate>
@property (nonatomic, assign)HNBusinessType businessType;
@property (nonatomic, assign)BOOL shouldRefresh;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *businessList;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UIBarButtonItem *filter;

@property (nonatomic, strong)NSMutableDictionary *goodsSearchDic;
@property (nonatomic, strong)NSMutableDictionary *orderSearchDic;
@property (nonatomic, strong)NSMutableDictionary *returnGoodsSearchDic;
@property (nonatomic, strong)NSMutableDictionary *commentDic;
@end

static NSString *reuseId = @"businessCell";
@implementation HNBusinessListViewController

- (instancetype)initWithType:(HNBusinessType)type{
    self = [super init];
    if (self){
        self.businessType = type;
        self.shouldRefresh = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.businessList = [[NSMutableArray alloc] init];
    __weak typeof (self) wself = self;
    [self.tableView addHeaderWithCallback:^{
        typeof (self) sself = wself;
        [sself refreshList];
    }];
    self.tableView.headerRefreshingText = @"刷新中";
    
    [self initHeaderViewWithType:self.businessType];
    
    
    self.tableView.top = self.headerView.bottom;
    self.tableView.height -= self.headerView.height;
    
    [self loadCellWithType:self.businessType];
    if (self.businessType == kGoods)
        [self initNavi];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tableView.height = self.view.height - self.headerView.height;
    [self.tableView headerBeginRefreshing];
}
- (void)initNavi{
    self.filter = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"筛选", nil) style:UIBarButtonItemStylePlain target:self action:@selector(filterData:)];
    self.navigationItem.rightBarButtonItem = self.filter;
}
- (void)loadCellWithType:(HNBusinessType)type{
    switch (type){
        case kGoods:
        {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNGoodsTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
            self.goodsSearchDic = [@{@"mshopid": [HNLoginData shared].mshopid , @"areaid":@"",@"goodsname":@"",@"classid":@"",@"goodstype":@"",@"ordertype":@"",@"imgwidth":@"100",@"imgheight":@"75",@"pagesize":@"",@"pageindex":@""}mutableCopy];
        }
            break;
        case kReturnGoods:
        {
            UINib *nib=[UINib nibWithNibName:NSStringFromClass([HNReturnsTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
            self.returnGoodsSearchDic = [@{@"mshopid": [HNLoginData shared].mshopid ,@"type":@"",@"orderid" : @"",@"pagesize":@"",@"pageindex":@""} mutableCopy];
        }
            break;
        case kComment:
        {
            UINib *nib=[UINib nibWithNibName:NSStringFromClass([HNCommentsTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
            self.commentDic = [@{@"mshopid": [HNLoginData shared].mshopid ,@"goodsid":@"",@"pagesize":@"",@"pageindex":@""} mutableCopy];
        }
            break;
        case kOrder:
        {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNOrderTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
            self.orderSearchDic = [@{@"mshopid": [HNLoginData shared].mshopid ,@"orderstate":@"",@"userid" : @"",@"orderid" : @"",@"timetype":@"",@"pagesize":@"",@"pageindex":@""} mutableCopy];
        }
            break;
        default:
            break;
    }
}
- (void)initHeaderViewWithType:(HNBusinessType)type{
    switch (type){
        case kGoods:
        {
            HNGoodsHeaderView *view = [[HNGoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
            [view.categoryButton addTarget:self action:@selector(goodsCategory:) forControlEvents:UIControlEventTouchUpInside];
            self.headerView = view;
        }
            break;
        case kReturnGoods:
        {
            self.headerView = [[HNReturnsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 74)];
            [self.view addSubview:self.headerView];
            break;
        }

        case kComment:
        {
//            self.headerView=[[HNCommentsHeaderView alloc] initWithFrame:CGRectMake(0,0, self.view.width, 74)];
            self.headerView = [UIView new];
        }
            break;
        case kOrder:
        {
            self.headerView = [[HNOrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        }
        default:
            break;
    }
    [self.view addSubview:self.headerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.businessList count];
    switch (self.businessType){
        case kReturnGoods:
            return 2;
            break;
        default:
            return 1;
            break;
            
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    switch (self.businessType){
        case kGoods:{
            HNGoodsTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:reuseId];
            [tCell setContent:self.businessList[indexPath.row]];
            cell = tCell;
        }
            break;
        case kReturnGoods:{
            HNReturnsTableViewCell *cCell=[tableView dequeueReusableCellWithIdentifier:reuseId];
            [cCell setContent:self.businessList[indexPath.row]];
            cell=cCell;
        }
            break;
        case kComment:{
            HNCommentsTableViewCell *cCell=[tableView dequeueReusableCellWithIdentifier:reuseId];
            [cCell setContent:self.businessList[indexPath.row]];
            cell=cCell;
        }
            break;
        case kOrder:{
            HNOrderTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:reuseId];
            [tCell setContent:self.businessList[indexPath.row]];
            cell = tCell;
        }
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.businessType){
        case kGoods:
        {
            HNGoodsViewController *goods = [[HNGoodsViewController alloc] init];
            NSString *goodsid = [NSString stringWithFormat:@"%@",self.businessList[indexPath.row][@"id"]];
            goods.goodsid = goodsid;
            [self.navigationController pushViewController:goods animated:YES];
        }
            break;

        case kOrder:
        {
            HNOrderViewController *order = [[HNOrderViewController alloc] init];
            NSString *orderid = [NSString stringWithFormat:@"%@",self.businessList[indexPath.row][@"orderid"]];
            order.orderid = orderid;
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
        case kReturnGoods:
        {
            HNBusinessBKReturnsModel *model = [[HNBusinessBKReturnsModel alloc]init];
            if (indexPath.row!=0) {
                model.returnsType = kReplaceGood;
            }
            HNReimburseViewController *reumburse = [[HNReimburseViewController alloc] init];
            reumburse.model = model;
            [self.navigationController pushViewController:reumburse animated:YES];

        }
            break;
        case kComment:
        {
            HNCommentsDetailViewController *commentDetail=[[HNCommentsDetailViewController alloc] init];
            commentDetail.index = 0;//((HNCommentsHeaderView*)self.headerView).segment.selectedSegmentIndex;
            [self.navigationController pushViewController:commentDetail animated:YES];
        }
            break;
        default:
        {
            
        }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.businessType){
        case kGoods:
            return 130;
            break;
        case kComment:
            return 100;
            break;
        case kReturnGoods:
            return 130;
            break;
            
        case kOrder:
            return 160;
            break;
        default:
            return 44;
            break;
    }
}
#pragma mark - LoadDataFromNet
- (void)refreshList{
    switch (self.businessType) {
        case kGoods:
            [self loadDataWithDic:self.goodsSearchDic withMethod:@"get.goods.list"];
            break;
        case kOrder:
            [self loadDataWithDic:self.orderSearchDic withMethod:@"get.order.list"];
            break;
        case kReturnGoods:
            [self loadDataWithDic:self.returnGoodsSearchDic withMethod:@"get.order.return"];
            break;
        case kComment:
            [self loadDataWithDic:self.commentDic withMethod:@"get.goods.comment"];
        default:
            break;
    }
}
- (void)loadThumbnail{
    switch (self.businessType) {
        case kGoods:
            [self loadThumbnailWithKey:@"pics"];
            break;
        case kOrder:
            [self loadOrderThumbnail];
        default:
            break;
    }
}
- (void)loadDefault{
    for (int i=0;i<[self.businessList count];i++)
    {
        id obj = self.businessList[i];
        NSMutableDictionary *dic = [obj mutableCopy];
        UIImage *defaultImage = [UIImage imageNamed:@"selectphoto.png"];
        [dic setObject:defaultImage forKey:@"uiimage"];
        [self.businessList replaceObjectAtIndex:i withObject:dic];
    }
}
- (void)loadOrderThumbnail{
    for (int i=0;i<[self.businessList count];i++){
        id obj = self.businessList[i];
        NSString *imgURL = [self.businessList[i] objectForKey:@"OrderGoods"][0][@"image"];
        NSMutableDictionary *dic = [obj mutableCopy];
        UIImage *image = [self imageWithLink:imgURL];
        [dic setObject:image forKey:@"uiimage"];
        [self.businessList replaceObjectAtIndex:i withObject:dic];
    }
}
- (void)loadThumbnailWithKey:(NSString *)key{
    for (int i=0;i<[self.businessList count];i++)
    {
        id obj = self.businessList[i];
        UIImage *image = [self imageWithLink:[obj objectForKey:key]];
        NSMutableDictionary *dic = [obj mutableCopy];
        [dic setObject:image forKey:@"uiimage"];
        [self.businessList replaceObjectAtIndex:i withObject:dic];
    }
}
- (UIImage *)imageWithLink:(NSString *)link{
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[link addPort]]]];
    return image? image : [UIImage imageNamed:@"selectphoto.png"];
}
- (void)loadDataWithDic:(NSMutableDictionary *)sendDic withMethod:(NSString *)method{
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:method Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView headerEndRefreshing];
        });
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0!=count){
                [self.businessList removeAllObjects];
                for (int i = 0; i< count; i++) {
                    [self.businessList addObject:[[retDic objectForKey:@"data"] objectAtIndex:i]];
                }
                [self loadDefault];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self loadThumbnail];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                });
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
            else
                [self showNoData];
        }else
            [self showNoNetwork];
    }];
}

- (void)showNoNetwork{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
    
}
- (void)showNoData{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"We don't get any data.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}
#pragma mark - actions
- (void)filterData:(id)sender{
    
}
- (void)goodsCategory:(id)sender{
    HNGoodsCategoriesViewController *vc = [[HNGoodsCategoriesViewController alloc] init];
    vc.headid = @"";
    vc.root = self;
    vc.goodsDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - HNGoodsCategoryDelegate
- (void)didSelectGoods:(NSString *)classid{
    NSLog(@"%@",classid);
}
@end
