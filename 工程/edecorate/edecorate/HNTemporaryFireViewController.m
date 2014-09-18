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

@interface HNTemporaryModel : NSObject
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSString *status;
@end
@implementation HNTemporaryModel
@end

@interface HNTemporaryFireViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tTableView;
@property (nonatomic, strong)NSMutableArray *reportList;
@property (nonatomic)HNTemporaryType temporaryType;
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
    
    self.reportList = [[NSMutableArray alloc] init];
    HNTemporaryModel *tModel = [[HNTemporaryModel alloc] init];
    tModel.roomName = @"施工房号：XXXX";
    tModel.status = @"审核进度:审核中";
    [self.reportList addObject:tModel];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger row = indexPath.row;
    HNTemporaryApplyViewController* tac = [[HNTemporaryApplyViewController alloc]init];
    [self.navigationController pushViewController:tac animated:YES];
    
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.reportList count];
}

- (HNTemporaryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"reportCell";
    HNTemporaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNTemporaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    HNTemporaryModel *model =self.reportList[indexPath.row];
    [cell setRoomName:model.roomName];
    [cell setStatus:model.status];
    return cell;
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
