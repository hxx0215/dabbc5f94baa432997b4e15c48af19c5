//
//  HNTemporaryFireViewController.m
//  edecorate
//
//  Created by 刘向宏 on 14-9-18.
//
//

#import "HNTemporaryFireViewController.h"
#import "HNTemporaryTableViewCell.h"
#import "HNTemporaryApplyViewController.h"
#import "HNTemporaryDetailsViewController.h"


@interface HNTemporaryFireViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tTableView;
@property (nonatomic, strong)NSMutableArray *modelList;
@property (nonatomic)HNTemporaryType temporaryType;
@property (nonatomic, strong)HNTemporaryTableViewCell* temporaryTableViewCell;
@end

@implementation HNTemporaryFireViewController

-(id)initWithTemporaryType:(HNTemporaryType)type
{
    self = [super init];
    self.temporaryType = type;
    return self;
}

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
    self.tTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tTableView.delegate = self;
    self.tTableView.dataSource = self;
    [self.view addSubview:self.tTableView];
    
    
    self.navigationItem.title = [self getTitleString];
    
    self.modelList = [[NSMutableArray alloc] init];
    HNTemporaryModel *tModel = [[HNTemporaryModel alloc] init];
    tModel.roomName = @"施工房号：XXXX";
    tModel.status = TemporaryStatusCustom;
    [self.modelList addObject:tModel];
}

-(NSString*)getTitleString
{
    if (self.temporaryType == FIRE) {
        return NSLocalizedString(@"Temporary fire", nil);
    }
    else if(self.temporaryType == POWER)
    {
        return NSLocalizedString(@"Temporary power", nil);
    }
    return @"";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.temporaryTableViewCell)
    {
        [self.temporaryTableViewCell update];
    }
    
}
#pragma mark - tableView Delegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.modelList count];
}

- (HNTemporaryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"reportCell";
    HNTemporaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        HNTemporaryModel *model =self.modelList[indexPath.row];
        cell = [[HNTemporaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier withModel:model];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.temporaryTableViewCell = (HNTemporaryTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSInteger row = indexPath.row;
    HNTemporaryModel* model = self.modelList[row];
    if(model.status==TemporaryStatusCustom)
    {
        HNTemporaryApplyViewController* tac = [[HNTemporaryApplyViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:tac animated:YES];
    }
    else
    {
        HNTemporaryDetailsViewController* tdc = [[HNTemporaryDetailsViewController alloc]initWithModel:model];
        [self.navigationController pushViewController:tdc animated:YES];
    }
    
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
