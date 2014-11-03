//
//  HNCheckViewController.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNCheckViewController.h"
#import "HNCheckDetailTableViewCell.h"

@interface HNCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation HNCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.contentArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.contentArr[section] objectForKey:@"Bodyitem"] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 50)];
    view.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = [self.contentArr[section] objectForKey:@"typename"];
    [label sizeToFit];
    label.centerY = view.height / 2;
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"CheckCell";
    HNCheckDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNCheckDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.nameLabel.text = [[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"name"];
    [cell.nameLabel sizeToFit];
    cell.contentLabel.text = [[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"img"];
    [cell.contentLabel sizeToFit];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",[[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"img"]);
}
@end
