//
//  HNDecorateCheckViewController.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNDecorateCheckViewController.h"
#import "HNCheckTableViewCell.h"
#import "HNCheckDetailViewController.h"

@interface HNCheckModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *checkSchedule;
@property (nonatomic, strong)NSString *checkStage;
@end
@implementation HNCheckModel
@end

@interface HNDecorateCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *cTableView;
@property (nonatomic, strong)NSMutableArray *checkList;

@end

@implementation HNDecorateCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Decorate Check", nil);
    self.cTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.cTableView.dataSource = self;
    self.cTableView.delegate = self;
    [self.view addSubview:self.cTableView];
    
    self.checkList = [[NSMutableArray alloc] init];
    
    HNCheckModel *model = [[HNCheckModel alloc] init];
    model.roomName =@"小区名房间号";
    model.checkSchedule = @"验收进度";
    model.checkStage = @"验收阶段";
    
    [self.checkList addObject:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.checkList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"checkCell";
    HNCheckTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNCheckTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    HNCheckModel *model = self.checkList[indexPath.row];
    cell.roomName.text = model.roomName;
    cell.checkSchedule.text = model.checkSchedule;
    cell.checkStage.text = model.checkStage;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HNCheckDetailViewController *checkDetail = [[HNCheckDetailViewController alloc] init];
    [self.navigationController pushViewController:checkDetail animated:YES];
}
@end
