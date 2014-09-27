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

@interface HNBusinessListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)HNBusinessType businessType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *businessList;
@end

static NSString *reuseId = @"businessCell";
@implementation HNBusinessListViewController

- (instancetype)initWithType:(HNBusinessType)type{
    self = [super init];
    if (!self){
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    headerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:headerView];
    
    self.tableView.top = headerView.bottom;
    self.tableView.height -= 40;
    
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
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.businessType){
        case kGoods:
        {
            HNGoodsViewController *goods = [[HNGoodsViewController alloc] init];
            [self.navigationController pushViewController:goods animated:YES];
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
        default:
            return 44;
            break;
    }
}
@end
