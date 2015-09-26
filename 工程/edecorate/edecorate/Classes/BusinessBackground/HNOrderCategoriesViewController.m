//
//  HNOrderCategoriesViewController.m
//  edecorate
//
//  Created by hxx on 11/27/14.
//
//

#import "HNOrderCategoriesViewController.h"

@interface HNOrderCategoriesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *selectData;
@end

@implementation HNOrderCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectData = @[NSLocalizedString(@"所有分类", nil),
                        NSLocalizedString(@"待付款", nil),
                        NSLocalizedString(@"待发货", nil),
                        NSLocalizedString(@"待收货", nil),
                        NSLocalizedString(@"待评价", nil),
                        NSLocalizedString(@"已完成", nil),
                        NSLocalizedString(@"已取消", nil),
                        NSLocalizedString(@"退换货", nil)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"OrderCateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.textLabel.text = self.selectData[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cateDelegate && [self.cateDelegate respondsToSelector:@selector(didSelect:name:)]){
        if (indexPath.row - 1 < 0)
            [self.cateDelegate didSelect:@"" name:self.selectData[indexPath.row]];
        else
            [self.cateDelegate didSelect:[NSString stringWithFormat:@"%d",indexPath.row - 1] name:self.selectData[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
