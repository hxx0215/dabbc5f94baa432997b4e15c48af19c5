//
//  HNGoodsCategoriesViewController.m
//  edecorate
//
//  Created by hxx on 11/21/14.
//
//

#import "HNGoodsCategoriesViewController.h"
@interface HNGoodsCategoriesViewController()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *list;
@end
@implementation HNGoodsCategoriesViewController
- (instancetype)init{
    self = [super init];
    if (self){
        self.headid = [NSString new];
    }
    return self;
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
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.list = [[NSMutableArray alloc] init];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    [self loadList];
}
- (void)loadList{
    NSDictionary *sendDic = @{@"headid": self.headid};
    NSString *sendJson = [sendDic JSONString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.goodsclass.list" Params:sendJson]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            if (0!=count){
                [self.list removeAllObjects];
                for (int i = 0; i< count; i++) {
                    [self.list addObject:[[retDic objectForKey:@"data"] objectAtIndex:i]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
            else
                [self showNoData];
        }
        else
            [self showNoNetwork];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"goodscatecell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.textLabel.text = [self.list[indexPath.row] objectForKey:@"catename"];
    if ([self.list[indexPath.row][@"isnext"] intValue] == 1)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.list[indexPath.row][@"isnext"] intValue] == 1){
        HNGoodsCategoriesViewController *vc = [[HNGoodsCategoriesViewController alloc] init];
        vc.headid = self.list[indexPath.row][@"classid"];
        vc.root = self.root;
        vc.goodsDelegate = self.goodsDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (self.goodsDelegate && [self.goodsDelegate respondsToSelector:@selector(didSelectGoods:)]){
            [self.goodsDelegate didSelectGoods:self.list[indexPath.row][@"classid"]];
        }
        [self.navigationController popToViewController:self.root animated:YES];
    }
}
@end
