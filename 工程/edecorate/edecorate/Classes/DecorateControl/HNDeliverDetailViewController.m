//
//  HNDeliverDetailViewController.m
//  edecorate
//
//  Created by hxx on 9/22/14.
//
//

#import "HNDeliverDetailViewController.h"
#import "UIView+AHKit.h"
#import "HNDeliverDetailTableViewCell.h"

@interface HNDeliverDetailViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIScrollView *backView;

@property (strong, nonatomic) IBOutlet UIView *viewRoom;
@property (strong, nonatomic) IBOutlet UIView *viewPrincipal ;
@property (strong, nonatomic) IBOutlet UIView *viewInformation;
@property (strong, nonatomic) IBOutlet UIView *viewPrice;


@property (nonatomic,strong) IBOutlet UILabel *houseInfoMain;

@property (nonatomic,strong) IBOutlet UILabel *houseInfoTitle;
@property (nonatomic,strong) IBOutlet UILabel *houseInfo;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwer;
@property (nonatomic,strong) IBOutlet UILabel *houseOnwerMobile;

@property (nonatomic,strong) IBOutlet UILabel *decorationCompanyTitle;
@property (nonatomic,strong) IBOutlet UILabel *decorationCompany;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMan;
@property (nonatomic,strong) IBOutlet UILabel *decorationChargeMobile;

@property (nonatomic,strong) IBOutlet UILabel *product;
@property (nonatomic,strong) IBOutlet UILabel *productTitle;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeTitleLabel;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic) NSInteger tableCellMun;
@end

@implementation HNDeliverDetailViewController

-(id)initWithModel:(HNDeliverData *)model{
    self = [super init];
    self.deliverModel = model;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = NSLocalizedString(@"送货安装", nil);
    
    self.houseInfoMain.text = NSLocalizedString(@"House Information", nil) ;
    [self labelWithTitle:NSLocalizedString(@"House Information", nil) label:self.houseInfoTitle];
    [self labelWithTitle:NSLocalizedString(@"Construction unit", nil) label:self.decorationCompanyTitle];
    
    [self labelWithTitle:self.deliverModel.roomnumber label:self.houseInfo];
    [self labelWithTitle:self.deliverModel.ownername label:self.houseOnwer];
    [self labelWithTitle:self.deliverModel.ownerphone label:self.houseOnwerMobile];
    self.houseOnwer.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.houseOnwerMobile.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.houseOnwerMobile sizeToFit ];
    [self.houseOnwer sizeToFit ];
    self.houseOnwerMobile.right = self.view.width - 14;
    self.houseOnwer.right = self.houseOnwerMobile.left-5;
    
    [self labelWithTitle:self.deliverModel.shopname label:self.decorationCompany];
    [self labelWithTitle:self.deliverModel.principal label:self.decorationChargeMan];
    [self labelWithTitle:self.deliverModel.EnterprisePhone label:self.decorationChargeMobile];
    self.decorationChargeMan.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    self.decorationChargeMobile.textColor = [UIColor colorWithRed:0xCC/255.0 green:0X91/255.0 blue:0X31/255.0 alpha:1];
    [self.decorationChargeMobile sizeToFit ];
    [self.decorationChargeMan sizeToFit ];
    self.decorationChargeMobile.right = self.view.width - 14;
    self.decorationChargeMan.right = self.decorationChargeMobile.left-5;
    
    self.product.text = self.deliverModel.product;
    self.productTitle.text = NSLocalizedString(@"送货安装产品", nil);
    self.timeTitleLabel.text = NSLocalizedString(@"起止日前", nil);
    NSDate *bdate = [[NSDate alloc]init];
    NSDate *edate = [[NSDate alloc]init];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDateFormatter *ff = [[NSDateFormatter alloc] init];
    [ff setDateFormat:@"YYYY/MM/dd"];
    bdate = [f dateFromString:self.deliverModel.bTime];
    edate = [f dateFromString:self.deliverModel.eTime];
    self.timeLabel.text = [NSString stringWithFormat:@"%@－%@",[ff stringFromDate:bdate],[ff stringFromDate:edate]];
    
    self.tableCellMun = [self.deliverModel.proposerItems count];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNDeliverDetailTableViewCell class]) bundle:nil];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.viewInformation.bottom, self.backView.width, 24+self.tableCellMun*150)];
    [self.backView addSubview:self.tableView];
    self.viewPrice.top = self.tableView.bottom;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"DeliverDetailCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)labelWithTitle:(NSString *)title label:(UILabel*)lab
{
    [lab setText:title];
    //[lab sizeToFit];
    //lab.font = [UIFont systemFontOfSize:12];
    //lab.numberOfLines = 2;
    //lab.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.width, self.viewPrice.bottom+20);
}

#pragma mark UITableViewDelegate
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.tableCellMun;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"DeliverDetailCell";
    HNDeliverDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell){
        cell = [[HNDeliverDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setData:[self.deliverModel.proposerItems objectAtIndex:indexPath.row]];
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
