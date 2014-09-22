//
//  HNDeliverViewController.m
//  edecorate
//
//  Created by hxx on 9/22/14.
//
//

#import "HNDeliverViewController.h"
#import "HNReportTableViewCell.h"

@interface HNDeliverModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@end
@implementation HNDeliverModel
@end
@interface HNDeliverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *dTableView;
@property (nonatomic, strong)NSMutableArray *deliverList;


@end

@implementation HNDeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Decorate Check", nil);
    self.dTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.dTableView.dataSource = self;
    self.dTableView.delegate = self;
    [self.view addSubview:self.dTableView];
    
    self.deliverList = [[NSMutableArray alloc] init];
    
    HNDeliverModel *model = [[HNDeliverModel alloc] init];
    model.roomName =@"小区名房间号";
    model.status = @"验收进度";
    
    [self.deliverList addObject:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.deliverList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"checkCell";
    HNReportTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNReportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    HNDeliverModel *model = self.deliverList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
