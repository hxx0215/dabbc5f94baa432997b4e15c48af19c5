//
//  HNConstructViewController.m
//  edecorate
//
//  Created by hxx on 10/23/14.
//
//

#import "HNConstructViewController.h"
#import "HNPurchaseViewController.h"
#import "HNPurchaseItem.h"

@interface HNConstructViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *companyData;
@property (nonatomic, strong)NSArray *personalData;
@property (nonatomic, strong)NSArray *graphData;

@end

@implementation HNConstructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.companyData = @[NSLocalizedString(@"营业执照", nil),NSLocalizedString(@"税务登记证",nil),NSLocalizedString(@"组织代码登记证",nil),NSLocalizedString(@"资质证书", nil),NSLocalizedString(@"电工证", nil),NSLocalizedString(@"法人委托书及法人身份证",nil),NSLocalizedString(@"施工负责人身份证",nil)];
    self.personalData = @[NSLocalizedString(@"姓名", nil),NSLocalizedString(@"联系电话",nil),NSLocalizedString(@"身份证号",nil)];
    self.graphData = @[NSLocalizedString(@"原始结构图", nil),NSLocalizedString(@"平面布置图",nil),NSLocalizedString(@"墙体改造图",nil),NSLocalizedString(@"天花布置图", nil),NSLocalizedString(@"水路布置图", nil),NSLocalizedString(@"电路分布图",nil)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self.tableView reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 88)];
    UIButton *purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    purchase.height = 40;
    purchase.width = self.view.width - 36;
    purchase.left = 18;
    purchase.centerY = 44;
    purchase.layer.cornerRadius = 5.0;
    [purchase setTitle:NSLocalizedString(@"前去支付费用", nil) forState:UIControlStateNormal];
    [purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0.0 alpha:1.0]];
    [purchase addTarget:self action:@selector(purchase:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:purchase];
    CGSize size = self.tableView.contentSize;
    view.top = size.height;
    [self.tableView addSubview:view];
    size.height += view.height;
    self.tableView.contentSize = size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section)
    {
        if (self.constructType < 2)
            return [self.companyData count];
        else
            return [self.personalData count];
    }
    else
        return [self.graphData count] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0==section)
        return 70;
    else
        return 230/2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    if (0==section){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 70)];
        
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        colorView.backgroundColor = [UIColor colorWithRed:0.0 green:188.0/255.0 blue:125.9/255.0 alpha:1.0];
        UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 18)];
        if (self.constructType < 2){
            colorLabel.text = NSLocalizedString(@"承包方式:公司承包装修", nil);
        }
        else{
            colorLabel.text = NSLocalizedString(@"承包方式:业主自装", nil);
        }

        colorLabel.textColor = [UIColor whiteColor];
        colorLabel.font = [UIFont systemFontOfSize:18.0];
        colorLabel.left = 27;
        colorLabel.centerY = colorView.height / 2;
        [colorView addSubview:colorLabel];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, 30)];
        titleView.backgroundColor = [UIColor colorWithRed:214.0/255.0 green:220/255.0 blue:224.0/255.0 alpha:1.0];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = NSLocalizedString(@"装修公司资料", nil);
        titleLabel.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        [titleLabel sizeToFit];
        titleLabel.left = 27;
        titleLabel.centerY = titleView.height / 2;
        [titleView addSubview:titleLabel];
        
        [view addSubview:colorView];
        [view addSubview:titleView];
    }
    else if (1 == section){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 115)];
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 85)];
        colorView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:145.0/255.0 blue:26.0/255.0 alpha:1.0];
        UILabel *colorLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 14, 45)];
        UILabel *colorLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, colorLabel1.width, 15)];
        colorLabel1.text = @"业主信息:深圳市罗湖区万科小区1栋3017";
        colorLabel2.text = @"李大木  13677899090";
        colorLabel1.numberOfLines = 2;
        colorLabel1.font = [UIFont systemFontOfSize:18];
        colorLabel1.top = 11;
        colorLabel1.right = self.view.width - 14;
        colorLabel1.textColor = [UIColor whiteColor];
        colorLabel1.textAlignment = NSTextAlignmentRight;
        
        colorLabel2.right = colorLabel1.right;
        colorLabel2.bottom = colorView.height - 9;
        colorLabel2.font = [UIFont systemFontOfSize:15];
        colorLabel2.textColor = [UIColor whiteColor];
        colorLabel2.textAlignment = NSTextAlignmentRight;
        [colorView addSubview:colorLabel1];
        [colorView addSubview:colorLabel2];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, self.view.width, 30)];
        titleView.backgroundColor = [UIColor colorWithRed:214.0/255.0 green:220/255.0 blue:224.0/255.0 alpha:1.0];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = NSLocalizedString(@"图纸资料", nil);
        titleLabel.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        [titleLabel sizeToFit];
        titleLabel.left = 27;
        titleLabel.centerY = titleView.height / 2;
        [titleView addSubview:titleLabel];
        
        [view addSubview:colorView];
        [view addSubview:titleView];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"ConstructCell";
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    if (0==indexPath.section){
        if (self.constructType < 2)
            cell.textLabel.text = self.companyData[indexPath.row];
        else
            cell.textLabel.text = self.personalData[indexPath.row];
    }
    else
        cell.textLabel.text = self.graphData[indexPath.row];
    return cell;
}

- (void)purchase:(UIButton *)sender{
    HNPurchaseViewController *pur = [[HNPurchaseViewController alloc] init];
    HNPurchaseItem *item = [[HNPurchaseItem alloc] init];
    item.title = @"装修保证金";
    item.price = 2000.0;
    item.single = 0;
    pur.mustPay = @[item];
    HNPurchaseItem *oItem = [[HNPurchaseItem alloc] init];
    oItem.title = @"装修垃圾下楼费";
    oItem.single = 1;
    oItem.nums = 3;
    oItem.unitPrice = 300.0;
    oItem.price = oItem.nums * oItem.unitPrice;
    pur.optionPay = @[oItem];
    [self.navigationController pushViewController:pur animated:YES];
}
@end
