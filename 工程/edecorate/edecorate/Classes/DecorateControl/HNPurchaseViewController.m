//
//  HNPurchaseViewController.m
//  edecorate
//
//  Created by hxx on 10/24/14.
//
//

#import "HNPurchaseViewController.h"
#import "HNPurchaseItem.h"
#import "HNPurchaseTableViewCell.h"
#import "MBProgressHUD.h"

@interface HNPurchaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSIndexPath *selectIndex;
@property (nonatomic, strong)UIView *purchaseView;
@property (nonatomic, strong)UILabel *totalLabel;
@property (nonatomic, strong)UIButton *purchase;
@property (nonatomic, strong)UIButton *checkAll;
@end

@implementation HNPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self initPurchaseView];
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
}
- (void)initPurchaseView{
    self.purchaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, 0, 19)];
    self.totalLabel.font = [UIFont systemFontOfSize:19.0];
    self.totalLabel.text = @"合计￥3160.00";
    [self.totalLabel sizeToFit];
    self.totalLabel.left = 27;
    self.totalLabel.centerY = 74;
    
    self.purchase = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.purchase setTitle:NSLocalizedString(@"在线支付", nil) forState:UIControlStateNormal];
    [self.purchase setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.purchase.width = 130;
    self.purchase.height = 40;
    self.purchase.right = self.view.width - 18;
    self.purchase.top = 54;
    [self.purchase setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:72.0/255.0 blue:0 alpha:1.0]];
    self.purchase.layer.cornerRadius = 5.0;
    
    [self.purchaseView addSubview:self.totalLabel];
    [self.purchaseView addSubview:self.purchase];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGSize size = self.tableView.contentSize;
    self.purchaseView.top = size.height;
    [self.tableView addSubview:self.purchaseView];
    size.height += self.purchaseView.height;
    self.tableView.contentSize = size;
    [self updateTotalPrice];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27, 0, view.width - 27, 14)];
    label.centerY = view.height / 2;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    if (0==section){
        view.backgroundColor = [UIColor colorWithRed:0 green:188.0/255.0 blue:125.0/255.0 alpha:1.0];
        label.text = NSLocalizedString(@"必交项目(单位:元)", nil);
    }
    else{
        view.backgroundColor = [UIColor colorWithRed:5.0/255.0 green:155.0/255.0 blue:239.0/255.0 alpha:1.0];
        label.text = NSLocalizedString(@"可选项目(单位:元)", nil);
        UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkBox setBackgroundImage:[UIImage imageNamed:@"purchasechekbox.png"] forState:UIControlStateNormal];
        [checkBox setImage:[UIImage imageNamed:@"purchasecheck.png"] forState:UIControlStateSelected];
        [checkBox addTarget:self action:@selector(checkAll:) forControlEvents:UIControlEventTouchUpInside];
        [checkBox sizeToFit];
        self.checkAll = checkBox;
        [view addSubview:checkBox];
        checkBox.left = 4;
        checkBox.centerY = label.centerY;
    }
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==section){
        return [self.mustPay count];
    }
    else if (1== section)
        return [self.optionPay count];
    else
        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        HNPurchaseItem *item = self.mustPay[indexPath.row];
        if (0 == item.single)
            return 45.0;
        else return 60.0;
    }
    else{
        HNPurchaseItem *item = self.optionPay[indexPath.row];
        if (0 == item.single)
            return 45.0;
        else return 60.0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath   {
    static NSString *identy = @"purchaseIdenty";
    HNPurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[HNPurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        [cell.checkButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    }
    HNPurchaseItem *item = nil;
    if (indexPath.section == 0)
    {
//        cell.textLabel.text = [self.mustPay[indexPath.row] title];
        item = self.mustPay[indexPath.row];
        cell.detail.textColor = [UIColor colorWithWhite:128.0/255.0 alpha:1.0];
        cell.checkButton.hidden = YES;
    }
    else{
        item = self.optionPay[indexPath.row];
        cell.detail.textColor = [UIColor colorWithRed:45.0/255.0 green:138.05 blue:204.0 alpha:1.0];
        cell.checkButton.hidden = NO;
    }
    cell.checkButton.tag = indexPath.row;
    cell.title.text = item.title;
    cell.price.text = [NSString stringWithFormat:@"%.2f",item.price];
    cell.single = item.single;
    cell.detail.text = [NSString stringWithFormat:@"单价%.2f    数量%d",item.unitPrice,(int)item.nums];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HNPurchaseTableViewCell *cell = (HNPurchaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.single != 0){
        self.selectIndex = indexPath;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"请输入数量", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *tf=[alert textFieldAtIndex:0];
        HNPurchaseItem *item = nil;
        if (indexPath.section == 0)
        {
            item = self.mustPay[indexPath.row];
        }
        else
        {
            item = self.optionPay[indexPath.row];
        }
        tf.text = [NSString stringWithFormat:@"%d",(int)item.nums];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [alert show];
    }
}
- (void)checkAll:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    [self.optionPay enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:1];
        HNPurchaseTableViewCell *cell = (HNPurchaseTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.checkButton.selected = sender.selected;
    }];
    [self updateTotalPrice];
}

- (void)check:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (!sender.selected)
        self.checkAll.selected = NO;
    [self updateTotalPrice];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UITextField *tf=[alertView textFieldAtIndex:0];
    if (1==buttonIndex){
        HNPurchaseItem *item = nil;
        if (self.selectIndex.section == 0){
            item = self.mustPay[self.selectIndex.row];
        }else{
            item= self.optionPay[self.selectIndex.row];
        }
        HNPurchaseTableViewCell *cell = (HNPurchaseTableViewCell *)[self.tableView cellForRowAtIndexPath:self.selectIndex];
        cell.detail.text = [NSString stringWithFormat:@"单价%.2f    数量%d",item.unitPrice,(int)[tf.text integerValue]];
        item.nums = [tf.text integerValue];
        item.price = item.nums * item.unitPrice;
        cell.price.text = [NSString stringWithFormat:@"%.2f",item.price];
        [self updateTotalPrice];
    }
}

- (void)updateTotalPrice{
    __block CGFloat total = 0;
    [self.mustPay enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        HNPurchaseItem *item = obj;
        total += item.price;
    }];
    [self.optionPay enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
        HNPurchaseItem *item = obj;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:1];
        HNPurchaseTableViewCell *cell = (HNPurchaseTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.checkButton.selected)
            total += item.price;
    }];
    self.totalLabel.text = [NSString stringWithFormat:@"合计￥%.2f",total];
    [self.totalLabel sizeToFit];
    self.totalLabel.right = self.purchase.left - 24;
}
@end
