//
//  HNOfficePassesViewController.m
//  edecorate
//
//  Created by 熊彬 on 14-9-19.
//
//

#import "HNOfficePassesViewController.h"
#import "HNTemporaryTableViewCell.h"

@interface HNOfficePassModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@end
@implementation HNOfficePassModel
@end


@interface HNOfficePassesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tTableView;
@property (nonatomic,strong) NSMutableArray *reportList;

@end

@implementation HNOfficePassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tTableView=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.delegate=self;
    self.tTableView.dataSource=self;
    [self.view addSubview:self.tTableView];
    
    self.navigationItem.title=@"办理出入证";
    self.reportList=[[NSMutableArray alloc] init];
    
    HNOfficePassModel *tModel=[[HNOfficePassModel alloc] init];
    tModel.roomName=@"施工房号：深圳市南山区大富大贵花园A座23G";
    tModel.status=@"审核进度：审核中";
    [self.reportList addObject:tModel];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.reportList count];
}

- (HNTemporaryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"reportCell";
    HNTemporaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNTemporaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNOfficePassModel *model =self.reportList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    return cell;
}




- (void)didReceiveMemoryWarning {
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
