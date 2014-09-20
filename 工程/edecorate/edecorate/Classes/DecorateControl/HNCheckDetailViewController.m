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

@interface HNCheckDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) IBOutlet UIScrollView *backView;
@property (strong, nonatomic) IBOutlet UIButton *originStructure;
@property (strong, nonatomic) IBOutlet UIButton *waterProof;
@property (strong, nonatomic) IBOutlet UIButton *Circuit;
@property (strong, nonatomic) IBOutlet UIButton *backFill;
@property (strong, nonatomic) IBOutlet UIButton *complete;
@property (strong, nonatomic) IBOutlet UIButton *submit;

@property (strong, nonatomic) NSMutableDictionary *uploadImages;
@property (assign, nonatomic) NSInteger shouldUploadNums;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIButton *curButton;

@property (strong, nonatomic) HNCheckDetailView *mainStruct;
@property (strong, nonatomic) NSMutableArray *mainStructItems;
@property (strong, nonatomic) HNCheckDetailView *gasPipe;
@property (strong, nonatomic) NSMutableArray *gasPipeItems;
@property (strong, nonatomic) UIView* originView;

@end

@implementation HNCheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.originStructure setTitle:NSLocalizedString(@"Origin", nil) forState:UIControlStateNormal];
    [self.waterProof setTitle:NSLocalizedString(@"Water", nil) forState:UIControlStateNormal];
    [self.Circuit setTitle:NSLocalizedString(@"Circuirt", nil) forState:UIControlStateNormal];
    [self.backFill setTitle:NSLocalizedString(@"Backfill", nil) forState:UIControlStateNormal];
    [self.complete setTitle:NSLocalizedString(@"Complete", nil) forState:UIControlStateNormal];

    self.uploadImages = [[NSMutableDictionary alloc] init];
    [self initMainStruct];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
}

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.shouldUploadNums != [self.uploadImages count])
        self.submit.enabled = NO;
}
- (void)initMainStruct{
    self.originView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.originView.top = self.originStructure.bottom;
    [self.backView addSubview:self.originView];
    self.mainStructItems = [@[NSLocalizedString(@"Kitchen Structure", nil),NSLocalizedString(@"WC Structure", nil),NSLocalizedString(@"House Structure", nil)] mutableCopy];
    self.mainStruct = [[HNCheckDetailView alloc] initWithTitle:@"主体结构" items:self.mainStructItems width:self.view.width];
    self.mainStruct.controller = self;
    [self.mainStruct setSelector:@selector(upload:)];
    [self.mainStruct setButtonTag:10];
    [self.originView addSubview:self.mainStruct];
//    self.mainStruct.top = self.originStructure.bottom;
    
    self.gasPipe = [[HNCheckDetailView alloc]initWithTitle:NSLocalizedString(@"Gas Pipe", nil) items:self.mainStructItems width:self.view.width];
    self.gasPipe.controller = self;
    [self.gasPipe setSelector:@selector(upload:)];
    [self.gasPipe setButtonTag:20];
    [self.originView  addSubview:self.gasPipe];
    self.gasPipe.top = self.mainStruct.bottom + 10;
    self.originView.height = self.gasPipe.bottom;
    self.shouldUploadNums = 6;
}

- (void)upload:(id)sender{
    self.curButton = (UIButton *)sender;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    [self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];;
}
- (IBAction)origin_Clicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self selectButton:btn];
}
- (IBAction)waterProof_Clicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self selectButton:btn];
}
- (IBAction)circuit_Clicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self selectButton:btn];
}
- (IBAction)backFill_Clicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self selectButton:btn];
}
- (IBAction)complete_Clicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self selectButton:btn];
}
- (void)selectButton:(UIButton *)btn{
    self.originStructure.selected = [btn isEqual:self.originStructure];
    self.waterProof.selected = [btn isEqual:self.waterProof];
    self.Circuit.selected = [btn isEqual:self.Circuit];
    self.backFill.selected = [btn isEqual:self.backFill];
    self.complete.selected = [btn isEqual:self.complete];
}
@end
