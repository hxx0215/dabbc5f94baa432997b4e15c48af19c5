//
//  ViewController.m
//  TableViewGrouped
//
//  Created by rongfzh on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HNCityChoiceViewController.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "HNLoginData.h"

@interface cityModel :NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *areaid;
@property (nonatomic,strong) NSString *abc;
@end

@implementation cityModel
@end

@interface HNCityChoiceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *arrayCity;
@property (nonatomic,strong) NSMutableArray *abcArray;
@end

@implementation HNCityChoiceViewController
@synthesize provinces;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Provineces" ofType:@"plist"];
    NSMutableArray *array=[[NSMutableArray  alloc] initWithContentsOfFile:plistPath];
    self.provinces = array;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.arrayCity = [[NSMutableDictionary alloc]init];
    self.abcArray = [[NSMutableArray alloc]init];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadMyData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -LoadMyData
-(void)loadMyData
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Loading", nil);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //HNLoginModel *model = [[HNLoginModel alloc] init];
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[HNLoginData shared].mshopid,@"mshopid", nil];
    //NSLog(@"%@",[HNLoginData shared].mshopid);
    NSString *jsonStr = @"{\"cityname\":\"\"}";//[dic JSONString];
    request.URL = [NSURL URLWithString:[NSString createResponseURLWithMethod:@"get.city.list" Params:jsonStr]];
    NSString *contentType = @"text/html";
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        [self performSelectorOnMainThread:@selector(didLoadMyData:) withObject:data waitUntilDone:YES];
    }];
}



-(void)didLoadMyData:(NSData*)data
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (data)
    {
        [self.arrayCity removeAllObjects];
        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *retJson =[NSString decodeFromPercentEscapeString:[retStr decryptWithDES]];
        //NSLog(@"%@",retJson);
        NSDictionary* dic = [retJson objectFromJSONString];
        NSNumber* total = [dic objectForKey:@"total"];
        
        if (total.intValue){//之后需要替换成status
            NSArray* array = [dic objectForKey:@"data"];
            for (int i = 0; i<[array count]; i++) {
                NSDictionary *dicData = [array objectAtIndex:i];
                cityModel *model = [[cityModel alloc]init];
                model.areaid = [dicData objectForKey:@"areaid"];
                model.name = [dicData objectForKey:@"name"];
                model.abc = [dicData objectForKey:@"abc"];
                NSMutableArray *array2 = [self.arrayCity objectForKey:model.abc];
                
                if (!array2) {
                    array2 = [[NSMutableArray alloc]init];
                    [self.arrayCity setObject:array2 forKey:model.abc];
                    [self.abcArray addObject:model.abc];
                }
                [array2 addObject:model];
            }
            NSComparator cmptr = ^(id obj1, id obj2){
                NSComparisonResult result = [obj1 compare:obj2];
                switch(result)
                {
                    case NSOrderedAscending:
                        return NSOrderedAscending;
                    case NSOrderedDescending:
                        return NSOrderedDescending;
                    case NSOrderedSame:
                        return NSOrderedSame;
                    default:
                        return NSOrderedSame;
                }
            };
            self.abcArray = [self.abcArray sortedArrayUsingComparator:cmptr];
            [self.tableView reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Fail", nil) message:NSLocalizedString(@"Please input correct username and password", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Connection Error", nil) message:NSLocalizedString(@"Please check your network.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - 
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //这个方法用来告诉表格有几个分组
    return [self.abcArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //这个方法告诉表格第section个分组有多少行
    NSArray *cities = [self.arrayCity objectForKey:[self.abcArray objectAtIndex:section]];
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //这个方法用来告诉某个分组的某一行是什么数据，返回一个UITableViewCell
    NSUInteger section = [indexPath section]; 
    NSUInteger row = [indexPath row]; 
    
    
    NSArray *cities = [self.arrayCity objectForKey:[self.abcArray objectAtIndex:section]];
    
    static NSString *GroupedTableIdentifier = @"cell"; 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: 
                             GroupedTableIdentifier]; 
    if (cell == nil) { 
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:GroupedTableIdentifier]; 
    } 
    
    cityModel *model = [cities objectAtIndex:row];
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor projectGreen];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //这个方法用来告诉表格第section分组的名称 
    NSString *provincName = [self.abcArray objectAtIndex:section];
    return provincName; 
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //返回省份的数组
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:35];
//    for (NSDictionary *dict in provinces) {
//        [array addObject:[dict objectForKey:@"p_Name"]];
//    }
 //   return array;
    return self.abcArray;
}



@end
