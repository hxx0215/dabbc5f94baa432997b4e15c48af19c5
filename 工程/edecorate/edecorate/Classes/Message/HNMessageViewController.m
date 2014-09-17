//
//  HNMessageViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNMessageViewController.h"
#import "HNMessageModel.h"

@interface HNMessageViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic, strong)UITableView *mTableView;
@property (nonatomic, strong)NSMutableArray *mList;
@end

@implementation HNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Message", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    
    self.mList = [[NSMutableArray alloc] init];
    HNMessageModel *m1= [[HNMessageModel alloc] init];
    m1.title = @"装修违规纠正通知";
    m1.date = @"2014年9月17日";
    [self.mList addObject:m1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTableView{
    self.mTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setMyInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    self.mTableView.frame =self.view.bounds;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString *reuseIdentify = @"messageCell";
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentify];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    HNMessageModel *messageModel = [self.mList objectAtIndex:indexPath.row];
    cell.textLabel.text = messageModel.title;
    cell.detailTextLabel.text = messageModel.date;
    return cell;
}
@end
