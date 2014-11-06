//
//  HNMessageViewController.m
//  edecorate
//
//  Created by hxx on 9/17/14.
//
//

#import "HNMessageViewController.h"
#import "HNMessageModel.h"
#import "HNMessageTableViewCell.h"

@interface HNMessageViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic, strong)UITableView *mTableView;
@property (nonatomic, strong)NSMutableArray *mList;
@end

@implementation HNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    self.title = NSLocalizedString(@"Message", nil);
    [self initTableView];
    
    self.mList = [[NSMutableArray alloc] init];
    HNMessageModel *m1= [[HNMessageModel alloc] init];
    m1.title = @"装修违规纠正通知";
    m1.messgae = @"  您在更美（毫州）华佗国际中药城1栋18号铺进行装..";
    m1.date = @"2014/9/17 14:30";
    [self.mList addObject:m1];
    HNMessageModel *m2= [[HNMessageModel alloc] init];
    m2.title = @"处罚单";
    m2.messgae = @"  您好！非常感谢阁下一直以来对我公司工作的支持和配合..";
    m2.date = @"2014/9/18 10:30";
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
    self.mTableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNMessageTableViewCell class]) bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"messageCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setMyInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    self.mTableView.frame = CGRectMake(12, 16, self.view.width-24, 129*2);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNMessageTableViewCell *cell;
    static NSString *reuseIdentify = @"messageCell";
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (!cell){
        cell = [[HNMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentify];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    HNMessageModel *messageModel = [self.mList objectAtIndex:indexPath.row];
    cell.labelTitle.text = messageModel.title;
    cell.labelMessage.text = messageModel.messgae;
    cell.labelDate.text = messageModel.date;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}
@end
