//
//  HNRefundTableViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-21.
//
//

#import "HNRefundTableViewController.h"
#import "HNRefundTableViewCell.h"
#import "HNRefundApplyViewController.h"
#import "HNRefundDetailViewController.h"

@interface HNRefundTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tTableView;
@property (nonatomic, strong)NSMutableArray *modelList;
@property (nonatomic, strong)HNRefundTableViewCell* refundTableViewCell;
@end


@implementation HNRefundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.delegate = self;
    self.tTableView.dataSource = self;
    [self.view addSubview:self.tTableView];
    
    
    self.navigationItem.title = NSLocalizedString(@"Deposit refund", nil);
    
    self.modelList = [[NSMutableArray alloc] init];
    HNTemporaryModel *tModel = [[HNTemporaryModel alloc] init];
    tModel.roomName = @"施工房号：XXXX";
    tModel.status = TemporaryStatusCustom;
    [self.modelList addObject:tModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.refundTableViewCell)
    {
        [self.refundTableViewCell updateMyCell];
    }
    
}
#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.modelList count];
}

- (HNRefundTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"refundCell";
    HNRefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        HNRefundTableViewCell *model =self.modelList[indexPath.row];
        cell = [[HNRefundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.refundTableViewCell = (HNRefundTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSInteger row = indexPath.row;
    HNTemporaryModel* model = self.modelList[row];
    if(model.status==TemporaryStatusCustom)
    {
        HNRefundApplyViewController* avc = [[HNRefundApplyViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:avc animated:YES];
    }
    else
    {
        HNRefundDetailViewController* dac = [[HNRefundDetailViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:dac animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
