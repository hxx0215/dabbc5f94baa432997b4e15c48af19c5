//
//  HNOfficePassesViewController.m
//  edecorate 出入证申请列表
//
//  Created by 熊彬 on 14-9-19.
//
//

#import "HNOfficePassesViewController.h"
#import "HNTemporaryTableViewCell.h"
#import "HNOfficePassesDetailsViewController.h"

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
    tModel.roomName=@"施工房号：大富大贵花园A座001";
    tModel.status=@"审核进度：审核中";
    [self.reportList addObject:tModel];
    
    HNOfficePassModel *TModel2=[[HNOfficePassModel alloc] init];
    TModel2.roomName=@"施工房号：大富大贵花园A座002";
    TModel2.status=@"审核进度：审核通过";
    [self.reportList addObject:TModel2];
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
        HNOfficePassModel *model =self.reportList[indexPath.row];
        cell = [[HNTemporaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNOfficePassesDetailsViewController *officePasseesApply=[[HNOfficePassesDetailsViewController alloc] init];
    [self.navigationController pushViewController:officePasseesApply animated:YES];
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
