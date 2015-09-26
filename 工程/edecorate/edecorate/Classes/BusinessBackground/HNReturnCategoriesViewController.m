//
//  HNReturnCategoriesViewController.m
//  edecorate
//
//  Created by hxx on 11/28/14.
//
//

#import "HNReturnCategoriesViewController.h"

@interface HNReturnCategoriesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *types;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation HNReturnCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.types = @[NSLocalizedString(@"所有分类", nil),
                   NSLocalizedString(@"退货", nil),
                   NSLocalizedString(@"换货", nil),
                   NSLocalizedString(@"报修", nil),
                   NSLocalizedString(@"退款", nil)];
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
    return [self.types count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"ReturnCateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.textLabel.text = self.types[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.cateDelegate && [self.cateDelegate respondsToSelector:@selector(didSelectType:name:)]){
        if (indexPath.row - 1 <0){
            [self.cateDelegate didSelectType:@"" name:self.types[indexPath.row]];
        }
        else
            [self.cateDelegate didSelectType:[NSString stringWithFormat:@"%d",indexPath.row -1] name:self.types[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
