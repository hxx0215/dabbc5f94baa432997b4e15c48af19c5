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
@interface HNBusinessListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)HNBusinessType businessType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *businessList;
@end

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
    
    [self.tableView addHeaderWithCallback:^{
        NSLog(@"下拉刷新中");
    }];
    self.tableView.headerRefreshingText = @"刷新中";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    headerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:headerView];
    
    self.tableView.top = headerView.bottom;
    self.tableView.height -= 40;
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
    static NSString *reuseIdentify = @"BusinessCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
    }
    cell.textLabel.text = @"商品名称";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView headerEndRefreshing];
}
@end
