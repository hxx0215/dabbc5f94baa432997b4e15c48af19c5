//
//  HNNewConstructViewController.m
//  edecorate
//
//  Created by hxx on 9/23/14.
//
//

#import "HNNewConstructViewController.h"
#import "UIView+AHKit.h"
#import "HNReportPurchaseViewController.h"

@interface HNNewConstructViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIView *purchaseListView;
@property (strong, nonatomic) IBOutlet UIButton *purchaseButton;
@property (strong, nonatomic) IBOutlet UILabel *uploadedLabel;
@property (strong, nonatomic) IBOutlet UIView *companyDataView;
@property (strong, nonatomic) IBOutlet UIView *ownerDataView;
@property (weak, nonatomic) UIButton *curButton;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@end

@implementation HNNewConstructViewController
- (instancetype)initWithConstructType:(HNConstructType)constructType{
    self = [super init];
    if (self){
        self.constructType = constructType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    if (kCompanyDetail == self.constructType)
    {
        self.purchaseListView.hidden = NO;
        self.purchaseButton.hidden = YES;
        __weak typeof (self) wself = self;
        void (^ changeButtonTitle)(id) = ^(id obj){
            if ([obj isKindOfClass:[UIButton class]])
            {
                typeof (self) sself = wself;
                UIButton *btn = (UIButton *)obj;
                [btn setTitle:NSLocalizedString(@"Look up", nil) forState:UIControlStateNormal];
                [btn sizeToFit];
                btn.width += 3;
                [btn removeTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(lookUpPic:) forControlEvents:UIControlEventTouchUpInside];
                [sself addUploadedLabelWithTag:btn.tag];
            }
        };

        [[self.companyDataView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            changeButtonTitle(obj);
        }];
        [[self.ownerDataView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            changeButtonTitle(obj);
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.backView.frame = self.view.bounds;
    self.backView.contentSize = CGSizeMake(self.view.width, self.purchaseListView.hidden ? self.purchaseButton.bottom + 10 : self.purchaseListView.bottom + 10);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addUploadedLabelWithTag:(NSInteger)tag{
    UILabel *label = (UILabel *)[self.backView viewWithTag:tag + 1000];
    if (!label)
    {
        label = [[UILabel alloc] init];
        label.text = self.uploadedLabel.text;
        label.size = self.uploadedLabel.size;
        label.font = self.uploadedLabel.font;
        label.hidden = NO;
        label.tag = tag + 1000;
        [self.backView addSubview:label];
        UIButton *btn = (UIButton *)[self.backView viewWithTag:tag];
        CGRect rect =[btn convertRect:btn.bounds toView:self.backView];
        label.right = rect.origin.x;
        label.centerY = CGRectGetMidY(rect);
        
    }
}
- (IBAction)purchase:(id)sender {
    HNReportPurchaseViewController *purchaseViewController = [[HNReportPurchaseViewController alloc] init];
    [self.navigationController pushViewController:purchaseViewController animated:YES];
}
- (IBAction)upload:(UIButton *)sender {
    self.curButton = sender;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)lookUpPic:(UIButton *)sender{
    NSLog(@"lookUp");
}
#pragma mark - imagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",image);
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self addUploadedLabelWithTag:self.curButton.tag];
    [self.curButton setTitle:NSLocalizedString(@"Change", nil) forState:UIControlStateNormal];
    [self.curButton sizeToFit];
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
