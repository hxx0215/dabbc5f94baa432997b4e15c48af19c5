//
//  HNNewReportViewController.m
//  edecorate
//
//  Created by hxx on 9/18/14.
//
//

#import "HNNewReportViewController.h"
#import "HNNewCompanyReportView.h"
#import "HNReportPurchaseViewController.h"

@interface HNNewReportViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HNNewCompanyReportViewDelegate>
@property (nonatomic, strong)UIScrollView *backView;
@property (nonatomic, strong)HNNewCompanyReportView *companyReportView;
@property (nonatomic, strong)UIImagePickerController *imagePicker;
@property (nonatomic, assign)NSInteger curButtonTag;
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
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    
    self.companyReportView = [[HNNewCompanyReportView alloc] initWithFrame:CGRectMake(0, 20, self.backView.bounds.size.width, self.backView.bounds.size.height * 2)];
    self.companyReportView.controller = self;
    [self.backView addSubview:self.companyReportView];
    [self.companyReportView.purchaseButton addTarget:self action:@selector(purchase:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate =self;
    self.imagePicker.sourceType = sourceType;
    self.imagePicker.allowsEditing = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setMyInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)setMyInterfaceOrientation:(UIInterfaceOrientation)orientation{
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.bounds.size.width, self.companyReportView.bounds.size.height + 20);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)purchase:(id)sender{
    HNReportPurchaseViewController *purchaseViewController = [[HNReportPurchaseViewController alloc] init];
    [self.navigationController pushViewController:purchaseViewController animated:YES];
}

- (void)companyReportView:(HNNewCompanyReportView *)reportView shouldUpload:(NSInteger)tag{
    self.curButtonTag = tag;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
     UIImage * image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    [self.companyReportView buttonImageSelected:self.curButtonTag];
}
@end
