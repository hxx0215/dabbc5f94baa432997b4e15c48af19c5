//
//  HNCheckViewController.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNCheckViewController.h"
#import "HNCheckDetailTableViewCell.h"
#import "MBProgressHUD.h"

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
    view.backgroundColor = [UIColor colorWithRed:144/255.0 green:197/255.0 blue:31/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc] init];
    label.text = [self.contentArr[section] objectForKey:@"typename"];
    label.textColor = [UIColor whiteColor];
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
    if ([[[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"type"] isEqualToString:@"1"])
    cell.contentLabel.text = [[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"img"];
    else{
        cell.contentLabel.text = NSLocalizedString(@"点击查看图片", nil);
    }
    [cell.contentLabel sizeToFit];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"type"] isEqualToString:@"2"]){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"loading", nil);
        __block UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn addTarget:self action:@selector(hideImg:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectZero;
        btn.center = CGPointMake([UIScreen mainScreen].bounds.size.width /2, [UIScreen mainScreen].bounds.size.height / 2);
        [[UIApplication sharedApplication].keyWindow addSubview:btn];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"%@",[[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"img"]);
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"img"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIImage *img = [UIImage imageWithData:imgData];
                if (imgData)
                    [btn setImage:img forState:UIControlStateNormal];
                else
                {
                    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    [btn setTitle:[NSString stringWithFormat:@"%@:\n%@",NSLocalizedString(@"糟糕链接失效了!图片地址为", nil),[[self.contentArr[indexPath.section] objectForKey:@"Bodyitem"][indexPath.row] objectForKey:@"img"]] forState:UIControlStateNormal];
                }
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     btn.frame = [UIScreen mainScreen].bounds;
                                 }];
            });
        });
    }
}
- (void)hideImg:(UIButton *)sender{
    [sender removeFromSuperview];
}
@end
