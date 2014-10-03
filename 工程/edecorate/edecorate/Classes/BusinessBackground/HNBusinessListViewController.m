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

#import "HNGoodsTableViewCell.h"
#import "HNGoodsViewController.h"
#import "HNGoodsHeaderView.h"

#import "HNReturnsHeaderView.h"
#import "HNReimburseViewController.h"
#import "HNReturnsTableViewCell.h"

#import "HNCommentsTableViewCell.h"
#import "HNCommentsHeaderView.h"
#import "HNCommentsDetailViewController.h"

#import "HNOrderHeaderView.h"
#import "HNOrderTableViewCell.h"
#import "HNOrderViewController.h"

@interface HNBusinessListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)HNBusinessType businessType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *businessList;
@property (nonatomic, strong)UIView *headerView;
@end

static NSString *reuseId = @"businessCell";
@implementation HNBusinessListViewController

- (instancetype)initWithType:(HNBusinessType)type{
    self = [super init];
    if (self){
        self.businessType = type;
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
    
    __weak typeof (self) wself = self;
    [self.tableView addHeaderWithCallback:^{
        NSLog(@"下拉刷新中");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            typeof (self) sself = wself;
            [sself.tableView headerEndRefreshing];
        });
    }];
    self.tableView.headerRefreshingText = @"刷新中";
    
    [self initHeaderViewWithType:self.businessType];
    
    
    self.tableView.top = self.headerView.bottom;
    self.tableView.height -= self.headerView.height;
    
    [self loadCellWithType:self.businessType];
}
- (void)loadCellWithType:(HNBusinessType)type{
    switch (type){
        case kGoods:
        {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNGoodsTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
        }
            break;
        case kReturnGoods:
        {
            UINib *nib=[UINib nibWithNibName:NSStringFromClass([HNReturnsTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
        }
            break;
        case kComment:
        {
            UINib *nib=[UINib nibWithNibName:NSStringFromClass([HNCommentsTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
        }
            break;
        case kOrder:
        {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNOrderTableViewCell class]) bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:reuseId];
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
            self.headerView = [[HNGoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 74)];
            
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
            self.headerView=[[HNCommentsHeaderView alloc] initWithFrame:CGRectMake(0,0, self.view.width, 74)];
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
            cell = tCell;
        }
            break;
        case kReturnGoods:{
            HNReturnsTableViewCell *cCell=[tableView dequeueReusableCellWithIdentifier:reuseId];
            cell=cCell;
        }
            break;
        case kComment:{
            HNCommentsTableViewCell *cCell=[tableView dequeueReusableCellWithIdentifier:reuseId];
            cell=cCell;
        }
            break;
        case kOrder:{
            HNOrderTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
            [self.navigationController pushViewController:goods animated:YES];
        }
            break;

        case kOrder:
        {
            HNOrderViewController *order = [[HNOrderViewController alloc] initWithType:kWaiting];
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
            commentDetail.index = ((HNCommentsHeaderView*)self.headerView).segment.selectedSegmentIndex;
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
            return 80;
            break;
        case kComment:
            return 120;
            break;
        case kReturnGoods:
            return [HNReturnsTableViewCell cellHeight];
            break;
            
        case kOrder:
            return 112;
            break;
        default:
            return 44;
            break;
    }
}
@end
