//
//  HNDecorateReportViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNDecorateReportViewController.h"
#import "HNReportTableViewCell.h"

@interface HNReportModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@end
@implementation HNReportModel
@end


@interface HNDecorateReportViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *rTableView;
@property (nonatomic, strong)NSMutableArray *reportList;
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
    self.rTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.rTableView.delegate = self;
    self.rTableView.dataSource = self;
    [self.view addSubview:self.rTableView];
    
    self.reportList = [[NSMutableArray alloc] init];
    HNReportModel *tModel = [[HNReportModel alloc] init];
    tModel.roomName = @"施工房号：XXXX";
    tModel.status = @"审核进度:审核中";
    [self.reportList addObject:tModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

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
@end
