//
//  HNCheckDetailViewController.m
//  edecorate
//
//  Created by hxx on 9/20/14.
//
//

#import "HNCheckDetailViewController.h"
#import "UIView+AHKit.h"
#import "HNCheckDetailView.h"

@interface HNCheckDetailViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIButton *originStructure;
@property (strong, nonatomic) IBOutlet UIButton *waterProof;
@property (strong, nonatomic) IBOutlet UIButton *Circuit;
@property (strong, nonatomic) IBOutlet UIButton *backFill;
@property (strong, nonatomic) IBOutlet UIButton *complete;
@property (strong, nonatomic) HNCheckDetailView *mainStruct;
@property (strong, nonatomic) NSMutableArray *mainStructItems;
@end

@implementation HNCheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.originStructure setTitle:NSLocalizedString(@"Origin", nil) forState:UIControlStateNormal];
    [self.waterProof setTitle:NSLocalizedString(@"Water", nil) forState:UIControlStateNormal];
    [self.Circuit setTitle:NSLocalizedString(@"Circuir", nil) forState:UIControlStateNormal];
    [self.backFill setTitle:NSLocalizedString(@"Backfill", nil) forState:UIControlStateNormal];
    [self.complete setTitle:NSLocalizedString(@"Complete", nil) forState:UIControlStateNormal];
    [self initMainStruct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMainStruct{
    self.mainStructItems = [@[NSLocalizedString(@"Kitchen Structure", nil),NSLocalizedString(@"WC Structure", nil),NSLocalizedString(@"House Structure", nil)] mutableCopy];
    self.mainStruct = [[HNCheckDetailView alloc] initWithTitle:@"主体结构" items:self.mainStructItems width:self.view.width];
    self.mainStruct.controller = self;
    [self.backView addSubview:self.mainStruct];
    self.mainStruct.top = self.originStructure.bottom;
}

- (void)upload:(id)sender{
    
}
@end
