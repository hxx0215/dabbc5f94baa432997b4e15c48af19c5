//
//  HNOfficePassesViewController.m
//  edecorate 出入证申请列表
//
//  Created by 熊彬 on 14-9-19.
//
//

#import "HNOfficePassesViewController.h"
#import "HNOfficePassedTableViewCell.h"
#import "HNOfficePassesDetailsViewController.h"
#import "HNOfficePassesApplyViewController.h"

//@interface HNOfficePassModel : NSObject
//@property (nonatomic, strong)NSString *roomName;
//@property (nonatomic, strong)NSString *status;
//@end
//@implementation HNOfficePassModel
//@end


@interface HNOfficePassesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tTableView;
@property (nonatomic,strong)NSMutableArray *modelList;
@property (nonatomic,strong)HNOfficePassedTableViewCell *passTableViewCell;

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
    self.modelList=[[NSMutableArray alloc] init];
    
    HNTemporaryModel *tModel=[[HNTemporaryModel alloc] init];
    tModel.roomName=@"施工房号：大富大贵花园A座001";
    tModel.status = TemporaryStatusCustom;
    [self.modelList addObject:tModel];
    
    HNTemporaryModel *TModel2=[[HNTemporaryModel alloc] init];
    TModel2.roomName=@"施工房号：大富大贵花园A座002";
    TModel2.status=TemporaryStatusCustom;
    [self.modelList addObject:TModel2];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.passTableViewCell)
    {
        [self.passTableViewCell updateMyCell];
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.modelList count];
}



-(HNOfficePassedTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"refundCell";
    HNOfficePassedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        HNTemporaryModel *model =self.modelList[indexPath.row];
        cell = [[HNOfficePassedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNTemporaryModel* model = self.modelList[indexPath.row];
    if(model.status==TemporaryStatusCustom)
    {
        HNOfficePassesApplyViewController* officePasseesApply=[[HNOfficePassesApplyViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:officePasseesApply animated:YES];
    }else{
        HNOfficePassesDetailsViewController *officeDetails=[[HNOfficePassesDetailsViewController alloc]  initWithModel:model];
        [self.navigationController pushViewController:officeDetails animated:YES];
    }
    
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
