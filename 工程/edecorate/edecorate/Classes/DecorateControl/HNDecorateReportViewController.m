//
//  HNDecorateReportViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNDecorateReportViewController.h"
#import "HNReportTableViewCell.h"
#import "HNNewReportViewController.h"

@interface HNReportModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@end
@implementation HNReportModel
@end


@interface HNDecorateReportViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *rTableView;
@property (nonatomic, strong)NSMutableArray *reportList;
@property (nonatomic, strong)UIBarButtonItem *reportButton;
@end

@implementation HNDecorateReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Decorate Construction", nil);
    self.rTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.rTableView.delegate = self;
    self.rTableView.dataSource = self;
    [self.view addSubview:self.rTableView];
    
//    self.reportButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Report", nil) style:UIBarButtonItemStylePlain target:self action:@selector(reportButton_Clicked:)];
//    self.navigationItem.rightBarButtonItem = self.reportButton;
    
    self.reportList = [[NSMutableArray alloc] init];
    HNReportModel *tModel = [[HNReportModel alloc] init];
    tModel.roomName = @"施工房号：XXXX";
    tModel.status = @"审核进度:审核中";
    [self.reportList addObject:tModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)reportButton_Clicked:(id)sender{
   
}
# pragma mark - tableViewDelegate & tableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.reportList count];
}

- (HNReportTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"reportCell";
    HNReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNReportModel *model =self.reportList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNNewReportViewController *newReportViewController = [[HNNewReportViewController alloc] init];
    [self.navigationController pushViewController:newReportViewController animated:YES];
}
@end
