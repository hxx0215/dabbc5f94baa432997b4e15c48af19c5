//
//  HNSelectChargeTableViewController.m
//  edecorate
//
//  Created by hxx on 12/2/14.
//
//

#import "HNSelectChargeTableViewController.h"
#import "MJRefresh.h"
#import "HNDecorateData.h"
#import "HNLoginData.h"

@interface HNSelectChargeTableViewController ()
@property (nonatomic, strong)NSMutableArray *dataList;
@property (nonatomic, assign)NSInteger realLength;
@end

@implementation HNSelectChargeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dataList = [NSMutableArray new];
    typeof(self) __weak weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        typeof(self) strongSelf = weakSelf;
        [strongSelf refreshList];
    }];
    [self.tableView addFooterWithCallback:^{
        typeof(self) strongSelf = weakSelf;
        [strongSelf loadMore];
    }];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = left;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView headerBeginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showBadServer{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil) message:NSLocalizedString(@"服务器出现错误，请联系管理人员", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles: nil];
        [alert show];
    });
}
- (void)loadMore{
    NSInteger nums = 50;
    if (0!=self.realLength % nums){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView footerEndRefreshing];
        });
        return ;//已到最后。返回
    }
    NSInteger page = self.realLength / nums + 1;
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid pageIndex:page pageSize:nums block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self.tableView footerEndRefreshing];
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            self.realLength += count;
            if (count!=0){
                for (int i=0;i<count;i++){
                    int processstep = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"processstep"] integerValue];
                    int assessorstate = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"assessorstate"] integerValue];
                    int paystate = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"paystate"] integerValue];
                    if (processstep != 0 && assessorstate !=0 && paystate!=0)
                    {
                        [self.dataList addObject:retDic[@"data"][i]];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
    }];
}
- (void)refreshList{
    [[HNDecorateData shared] loadingDecorateData:[HNLoginData shared].mshopid pageIndex:0 pageSize:50 block:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        [self.tableView headerEndRefreshing];
        if (data){
            NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if (!retStr){
                [self showBadServer];
                return ;
            }
            NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
            NSDictionary *retDic = [retJson objectFromJSONString];
            NSInteger count = [[retDic objectForKey:@"total"] integerValue];
            self.realLength +=count;
            if (count!=0){
                [self.dataList removeAllObjects];
                for (int i=0;i<count;i++){
                    int processstep = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"processstep"] integerValue];
                    int assessorstate = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"assessorstate"] integerValue];
                    int paystate = [[[[retDic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"paystate"] integerValue];
                    if (processstep != 0 && assessorstate !=0 && paystate!=0)
                    {
                        [self.dataList addObject:retDic[@"data"][i]];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            });
            
        }
    }];
}
- (void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identy = @"selectCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    // Configure the cell...
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.text = self.dataList[indexPath.row][@"roomnumber"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.chargeDelegate && [self.chargeDelegate respondsToSelector:@selector(didSelect:declareId:data:)]){
        [self.chargeDelegate didSelect:self.dataList[indexPath.row][@"roomnumber"] declareId:self.dataList[indexPath.row][@"declareId"] data:self.dataList[indexPath.row]];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
