//
//  HNCheckViewController.m
//  edecorate
//
//  Created by hxx on 11/2/14.
//
//

#import "HNCheckViewController.h"
#import "HNCheckDetailTableViewCell.h"
#import "MBProgressHUD.h"
#import "HNBrowseImageViewController.h"
#import "HNConsturctPicTableViewCell.h"

@interface HNCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *tableTitle;
@property (nonatomic, strong)NSArray *checkInfo;
@property (nonatomic, strong)NSArray *managerTitle;
@property (nonatomic, strong)NSArray *ownTitle;
@property (nonatomic, strong)NSMutableArray *headTitle;
@property (nonatomic, strong)NSMutableDictionary *imgCache;

@property (nonatomic, strong)NSMutableDictionary *imageSet;
@property (nonatomic, strong)NSMutableDictionary *curImageIndex;
@property (nonatomic, strong)NSMutableDictionary *imageUrl;
@end

@implementation HNCheckViewController
//NSString *(^ localeString)(NSString *,NSString *) = ^(NSString * local,NSString *append){
//    return [NSString stringWithFormat:@"%@%@",NSLocalizedString(local, nil),append];
//};
static NSString *localeString(NSString *local,NSString *append){
    return [NSString stringWithFormat:@"%@%@",NSLocalizedString(local, nil),append];
}
static NSString *kCheckDetailCell = @"kCheckDetailCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HNConsturctPicTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCheckDetailCell];
    
    NSDictionary *dic = @{@"-1": NSLocalizedString(@"未通过", nil),@"1": NSLocalizedString(@"通过", nil),@"0" : NSLocalizedString(@"审核中", nil)};
    self.checkInfo = @[localeString(@"申请验收时间",self.declaretime),localeString(@"施工方备注 :", self.shopreason),localeString(@"施工方附件", @"")];
    self.managerTitle = @[localeString(@"物业审核状态 :", dic[self.manageAssessor]),localeString(@"物业审核备注 :", self.manageckreason),localeString(@"物业审核时间 :", self.managecktime),localeString(@"物业审核附件",@"")];
    self.ownTitle = @[localeString(@"业主审核状态 :", dic[self.ownerAssessor]),localeString(@"业主审核备注 :", self.ownerckreason),localeString(@"业主审核时间 :", self.ownercktime),localeString(@"业主审核附件",@"")];
    self.headTitle = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%@ : %@",self.processname,dic[[NSString stringWithFormat:@"%d",self.state]]],NSLocalizedString(@"验收信息", nil),NSLocalizedString(@"物业审核", nil),NSLocalizedString(@"业主审核", nil), nil];
    for (id obj in self.contentArr){
        [self.headTitle addObject:[NSString stringWithFormat:@"%@",[obj objectForKey:@"typename"]]];
    }
    self.tableTitle = [[NSMutableArray alloc] init];
    [self.tableTitle addObject:[NSArray new]];
    [self.tableTitle addObject:self.checkInfo];
    [self.tableTitle addObject:self.managerTitle];
    [self.tableTitle addObject:self.ownTitle];
    [self.contentArr enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
        [self.tableTitle addObject:[obj objectForKey:@"Bodyitem"]];
    }];
    self.imgCache = [[NSMutableDictionary alloc] init];
    self.imageSet = [NSMutableDictionary new];
    self.imageUrl = [NSMutableDictionary new];
    self.curImageIndex = [NSMutableDictionary new];
    
    [self loadImages];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.tableTitle count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableTitle[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 55)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, tableView.width - 20, 50)];
    contentView.backgroundColor = [UIColor projectGreen];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    if ([self.tableTitle[section] count]==0)
        maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    [view addSubview:contentView];
    UILabel *label = [[UILabel alloc] init];
    label.text = self.headTitle[section];
    [label sizeToFit];
    label.textColor = [UIColor whiteColor];
    label.left = 5;
    label.centerY = contentView.height / 2;
    [contentView addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self shouldShowCom:indexPath])
        return 115;
    return 60;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 7.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                /*} else if (indexPath.row == 0) {
                 CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                 CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                 addLine = YES;*/
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
            
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"CheckCell";
    HNCheckDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[HNCheckDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//        [cell.photo addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.section <4)
        cell.nameLabel.text = self.tableTitle[indexPath.section][indexPath.row];
    else
        cell.nameLabel.text = self.tableTitle[indexPath.section][indexPath.row][@"name"];
    cell.photo.hidden = YES;
    cell.contentLabel.hidden = YES;
    if (indexPath.section<4 && indexPath.row == [self.tableTitle[indexPath.section] count] - 1){
        cell.photo.hidden = NO;
//        UIImage *img = [self.imgCache objectForKey:indexPath];
//        switch (indexPath.section) {
//            case 1:
//            {
//                if (!img)
//                {
//                    img = [self imageWithLink:self.shopaccessory];
//                    [self.imgCache setObject:img forKey:indexPath];
//                }
//                [cell.photo setImage:img forState:UIControlStateNormal];
//            }
//                break;
//            case 2:{
//                if (!img){
//                    img = [self imageWithLink:self.manageraccessory];
//                    [self.imgCache setObject:img forKey:indexPath];
//                }
//                [cell.photo setImage:img forState:UIControlStateNormal];
//            }
//                break;
//            case 3:{
//                if (!img){
//                    img = [self imageWithLink:self.owneraccessory];
//                    [self.imgCache setObject:img forKey:indexPath];
//                }
//                [cell.photo setImage:img forState:UIControlStateNormal];
//            }
//            default:
//                break;
//        }
    }
    if (indexPath.section >= 4)
    {
        if (2 ==[self.tableTitle[indexPath.section][indexPath.row][@"type"] integerValue]){
            
            cell.photo.hidden = NO;
//            UIImage *img = [self.imgCache objectForKey:indexPath];
//            if (!img){
//                img = [self imageWithLink:self.tableTitle[indexPath.section][indexPath.row][@"img"]];
//                [self.imgCache setObject:img forKey:indexPath];
//            }
//            [cell.photo setImage:img forState:UIControlStateNormal];
        }
        else{
            cell.contentLabel.text = self.tableTitle[indexPath.section][indexPath.row][@"img"];
            cell.contentLabel.hidden = NO;
        }
    }
    if (!cell.photo.hidden){
        HNConsturctPicTableViewCell *tCell = [tableView dequeueReusableCellWithIdentifier:kCheckDetailCell];
        tCell.contentView.tag = indexPath.section * 100 + indexPath.row;
        [tCell.leftImg removeTarget:self action:@selector(leftImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.leftImg addTarget:self action:@selector(leftImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.rightImg removeTarget:self action:@selector(rightImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.rightImg addTarget:self action:@selector(rightImage:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.showPic removeTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
        [tCell.showPic addTarget:self action:@selector(showPic:) forControlEvents:UIControlEventTouchUpInside];
        tCell.delImage.hidden = YES;
        tCell.uploadImage.hidden = YES;
        tCell.titleText.text = cell.nameLabel.text;
        [self configCell:tCell showOther:[self shouldShowCom:indexPath]];
        [tCell.titleText sizeToFit];
        if (self.imageSet[indexPath]!=[NSNull null]){
            NSArray *imageArr = self.imageSet[indexPath];
            if (imageArr && [imageArr count]>0)
            {
                NSInteger index = [self.curImageIndex[indexPath] integerValue];
                tCell.pic.image = imageArr[index];
                tCell.leftImg.hidden = ([imageArr count]==1);
                tCell.rightImg.hidden = ([imageArr count]==1);
            }
        }
        return tCell;
    }
    [cell.nameLabel sizeToFit];
    [cell.contentLabel sizeToFit];
    return cell;
}
- (void)configCell:(HNConsturctPicTableViewCell *)cell showOther:(BOOL)show{
    cell.leftImg.hidden = !show;
    cell.rightImg.hidden = !show;
    cell.pic.hidden = !show;
}
- (BOOL)shouldShowCom:(NSIndexPath *)indexPath{
    NSIndexPath *idp = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    if (self.imageSet[idp]!=[NSNull null]){
        NSArray *imageArr = self.imageSet[idp];
        if (imageArr && [imageArr count]>0)
            return YES;
    }
    return NO;
}
- (UIImage *)imageWithLink:(NSString *)link{
    UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[link addPort]]]];
    return image? image : [UIImage imageNamed:@"selectphoto.png"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)loadImages{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
    [self.imageUrl setObject:self.shopaccessory forKey:indexPath];
    [self.imageSet setObject:[self imagesFromUrl:self.shopaccessory] forKey:indexPath];
    [self.curImageIndex setObject:@(0) forKey:indexPath];
    indexPath = [NSIndexPath indexPathForRow:3 inSection:2];
    [self.imageUrl setObject:self.manageraccessory forKey:indexPath];
    [self.imageSet setObject:[self imagesFromUrl:self.manageraccessory] forKey:indexPath];
    [self.curImageIndex setObject:@(0) forKey:indexPath];
    indexPath = [NSIndexPath indexPathForRow:3 inSection:3];
    [self.imageUrl setObject:self.owneraccessory forKey:indexPath];
    [self.imageSet setObject:[self imagesFromUrl:self.owneraccessory] forKey:indexPath];
    [self.curImageIndex setObject:@(0) forKey:indexPath];
    for (int i=4;i<[self.tableTitle count];i++)
        for (int j=0;j<[self.tableTitle[i] count];j++)
            if ([self.tableTitle[i][j][@"type"] integerValue] == 2){
                indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                NSString *url = self.tableTitle[indexPath.section][indexPath.row][@"img"];
                [self.imageUrl setObject:url forKey:indexPath];
                [self.imageSet setObject:[self imagesFromUrl:url] forKey:indexPath];
                [self.curImageIndex setObject:@(0) forKey:indexPath];
            }
}
- (NSObject *)imagesFromUrl:(NSString *)urls{
    if ([urls isEqualToString:@""])
        return [NSNull null];
    NSArray *list = [urls componentsSeparatedByString:@","];
    if ([list count]<1)
        return [NSNull null];
    NSMutableArray *images = [NSMutableArray new];
    for (NSString *url in list)
    {
        [images addObject:[self imageWithLink:url]];
    }
    return images;
}
- (void)leftImage:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSInteger curIndex = [self.curImageIndex[indexPath] integerValue];
    curIndex -- ;
    if (curIndex <0) curIndex = 0;
    self.curImageIndex[indexPath] = @(curIndex);
    [self.tableView reloadData];
}
- (void)rightImage:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSInteger curIndex = [self.curImageIndex[indexPath] integerValue];
    NSInteger maxIndex = [self.imageSet[indexPath] count];
    curIndex ++;
    if (curIndex > maxIndex - 1) curIndex = maxIndex - 1;
    self.curImageIndex[indexPath] = @(curIndex);
    [self.tableView reloadData];
}
- (void)showPic:(UIButton *)sender{
    NSInteger section = [sender superview].tag / 100;
    NSInteger row = [sender superview].tag % 100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    NSArray *imageArr = self.imageSet[indexPath];
    NSInteger index = [self.curImageIndex[indexPath] integerValue];
    UIImage *image = imageArr[index];
    HNBrowseImageViewController *vc = [[HNBrowseImageViewController alloc] init];
    vc.image = image;
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}
@end
