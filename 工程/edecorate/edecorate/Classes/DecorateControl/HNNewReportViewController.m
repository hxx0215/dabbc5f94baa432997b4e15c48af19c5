//
//  HNNewReportViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNNewReportViewController.h"

@interface HNNewReportViewController ()
@property (nonatomic, strong)UIScrollView *backView;
@end

@implementation HNNewReportViewController

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
    self.title = NSLocalizedString(@"Decorate Construction", nil);
    self.backView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.backView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.backView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setMyInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 20);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
