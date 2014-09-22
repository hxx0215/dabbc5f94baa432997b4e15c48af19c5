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
#import "CTAssetsPickerController.h"

@interface HNCheckDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>
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
@property (strong, nonatomic) CTAssetsPickerController *assPicker;

@property (strong, nonatomic) UIView *originView;
@property (strong, nonatomic) HNCheckDetailView *mainStruct;
@property (strong, nonatomic) NSMutableArray *mainStructItems;
@property (strong, nonatomic) HNCheckDetailView *gasPipe;
@property (strong, nonatomic) NSMutableArray *gasPipeItems;

@property (strong, nonatomic) UIView *waterProofView;
@property (strong, nonatomic) HNCheckDetailView *proof;
@property (strong, nonatomic) NSMutableArray *proofItems;
@property (strong, nonatomic) HNCheckDetailView *closeWater;
@property (strong, nonatomic) NSMutableArray *closeItems;

@property (strong, nonatomic) UIView *circuitView;
@property (strong, nonatomic) HNCheckDetailView *suppressing;
@property (strong, nonatomic) NSMutableArray *suppressingItems;
@property (strong, nonatomic) HNCheckDetailView *circuitdetail;
@property (strong, nonatomic) NSMutableArray *circuitItems;

@property (strong, nonatomic) UIView *backFillView;
@property (strong, nonatomic) NSMutableArray *backFillDetails;
@property (strong, nonatomic) NSMutableArray *backFillItems;
@property (strong, nonatomic) UIButton *addKitchenWashroom;
@property (assign, nonatomic) NSInteger backFillbase;

@property (strong, nonatomic) UIView *completeView;
@property (strong, nonatomic) HNCheckDetailView *completeDetail;
@property (strong, nonatomic) NSMutableArray *completeItems;
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
    [self initWaterProof];
    [self initCircuit];
    [self initBackFill];
    [self initComplete];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    
    self.assPicker = [[CTAssetsPickerController alloc] init];
    self.assPicker.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.shouldUploadNums != [self.uploadImages count])
        self.submit.enabled = NO;
    [self origin_Clicked:self.originStructure];
}
- (UIView *)createContentView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    view.top = self.originStructure.bottom;
    [self.backView addSubview:view];
    view.hidden = YES;
    return view;
}
- (HNCheckDetailView *)createDetailViewWithTitile:(NSString *)title items:(NSMutableArray *)items selector:(SEL)selector base:(NSInteger)base{
    HNCheckDetailView *detailView =[[HNCheckDetailView alloc] initWithTitle:title items:items width:self.view.width];
    detailView.controller = self;
    [detailView setSelector:selector];
    [detailView setButtonTag:base];
    return detailView;
}
- (void)initMainStruct{
    self.originView = [self createContentView];
    self.mainStructItems = [@[NSLocalizedString(@"Kitchen Structure", nil),NSLocalizedString(@"WC Structure", nil),NSLocalizedString(@"House Structure", nil)] mutableCopy];
    self.mainStruct = [self createDetailViewWithTitile:NSLocalizedString(@"Main Structure", nil) items:self.mainStructItems selector:@selector(upload:) base:10];
    [self.originView addSubview:self.mainStruct];
    
    self.gasPipe = [self createDetailViewWithTitile:NSLocalizedString(@"Gas Pipe", nil) items:self.mainStructItems selector:@selector(upload:) base:20];
    [self.originView  addSubview:self.gasPipe];
    self.gasPipe.top = self.mainStruct.bottom + 10;
    self.originView.height = self.gasPipe.bottom;
    self.shouldUploadNums = 6;
}
- (void)initWaterProof{
    self.waterProofView = [self createContentView];
    self.proofItems = [@[NSLocalizedString(@"Kitchen Floor", nil),NSLocalizedString(@"Kitchen Wall", nil),NSLocalizedString(@"Washroom", nil),NSLocalizedString(@"Bath Area", nil),NSLocalizedString(@"Washroom Floor", nil)] mutableCopy];
    self.proof = [self createDetailViewWithTitile:NSLocalizedString(@"Water Proof", nil) items:self.proofItems selector:@selector(upload:) base:30];
    [self.waterProofView addSubview:self.proof];
    
    self.closeItems = [@[NSLocalizedString(@"Beginning Close", nil),NSLocalizedString(@"48 hour Close", nil)] mutableCopy];
    self.closeWater = [self createDetailViewWithTitile:NSLocalizedString(@"Water Close", nil) items:self.closeItems selector:@selector(upload:) base:40];
    [self.waterProofView addSubview:self.closeWater];
    self.closeWater.top = self.proof.bottom + 10;
    self.waterProofView.height = self.closeWater.bottom;
}

- (void)initCircuit{
    self.circuitView = [self createContentView];
    self.suppressingItems = [@[NSLocalizedString(@"Beginning Suppressing", nil),NSLocalizedString(@"8 hours Suppressing", nil)] mutableCopy];
    self.suppressing = [self createDetailViewWithTitile:NSLocalizedString(@"Suppressing", nil) items:self.suppressingItems selector:@selector(upload:) base:50];
    [self.circuitView addSubview:self.suppressing];
    
    self.circuitItems = [@[NSLocalizedString(@"Kitchen Circuit", nil),NSLocalizedString(@"Washroom Circuit", nil)] mutableCopy];
    self.circuitdetail = [self createDetailViewWithTitile:NSLocalizedString(@"Circuit", nil) items:self.circuitItems selector:@selector(upload:) base:60];
    [self.circuitView addSubview:self.circuitdetail];
    self.circuitdetail.top = self.suppressing.bottom + 10;
    self.circuitView.height = self.circuitdetail.bottom;
}

- (void)initBackFill{
    self.backFillbase = 300;
    self.backFillView = [self createContentView];
    self.backFillItems = [@[NSLocalizedString(@"Before Backfill", nil),NSLocalizedString(@"After Backfill", nil)] mutableCopy];
    self.backFillDetails = [[NSMutableArray alloc] init];
    HNCheckDetailView *washroom = [self createDetailViewWithTitile:[NSString stringWithFormat:@"%@%d",NSLocalizedString(@"Washroom", nil),[self.backFillDetails count] + 1] items:self.backFillItems selector:@selector(upload:) base:self.backFillbase + [self.backFillDetails count]];
    [self.backFillDetails addObject:washroom];
    __block CGFloat top = 0;
    [self.backFillDetails enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop){
        [self.backFillView addSubview:view];
        view.top = top;
        top = view.bottom;
    }];
    self.addKitchenWashroom = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addKitchenWashroom setTintColor:[UIColor blueColor]];
//    self.addKitchenWashroom.selected = YES;
    [self.addKitchenWashroom setTitle:NSLocalizedString(@"Add Kitchen", nil) forState:UIControlStateNormal];
    [self.addKitchenWashroom setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.addKitchenWashroom sizeToFit];
    self.addKitchenWashroom.layer.borderColor = [UIColor blackColor].CGColor;
    self.addKitchenWashroom.layer.borderWidth = 1.0;
    self.addKitchenWashroom.top = top + 10;
    top = self.addKitchenWashroom.bottom;
    [self.addKitchenWashroom addTarget:self action:@selector(addKitchen:) forControlEvents:UIControlEventTouchUpInside];
    [self.backFillView addSubview:self.addKitchenWashroom];
    UIButton *tBtn = [washroom.buttons lastObject];
    self.addKitchenWashroom.centerX = tBtn.centerX;
    self.backFillView.height = self.addKitchenWashroom.bottom;
}
- (void)initComplete{
    self.completeView = [self createContentView];
    self.completeItems = [@[NSLocalizedString(@"Main Structure(3 Pics)", nil),NSLocalizedString(@"Out elevation(3 Pics)", nil),NSLocalizedString(@"Gas Pipes(3 Pics)", nil),NSLocalizedString(@"Air condtion(3 Pics)", nil),NSLocalizedString(@"Public(3 Pics)", nil),NSLocalizedString(@"Complete Drawing(3 Pics)", nil),NSLocalizedString(@"Force & Weak Circuit(3 Pics)", nil)] mutableCopy];
    self.completeDetail = [self createDetailViewWithTitile:@"" items:self.completeItems selector:@selector(uploadPics:) base:70];
    [self.completeView addSubview:self.completeDetail];
    self.completeView.height = self.completeDetail.bottom;
}
- (void)addKitchen:(id)sender{
    HNCheckDetailView *washroom = [self createDetailViewWithTitile:[NSString stringWithFormat:@"%@%d",NSLocalizedString(@"Washroom", nil),[self.backFillDetails count] + 1] items:self.backFillItems selector:@selector(upload:) base:self.backFillbase + [self.backFillDetails count] * 10];
    [self.backFillView addSubview:washroom];
    HNCheckDetailView *lastView = [self.backFillDetails lastObject];
    washroom.top = lastView.bottom;
    self.addKitchenWashroom.top = washroom.bottom + 10;
    [self.backFillDetails addObject:washroom];
    self.backFillView.height = self.addKitchenWashroom.bottom;
}
- (void)upload:(id)sender{
    self.curButton = (UIButton *)sender;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
//    [self presentViewController:self.assPicker animated:YES completion:nil];
}
- (void)uploadPics:(id)sender{
    self.curButton = (UIButton *)sender;
    [self presentViewController:self.assPicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    [self.uploadImages setObject:image forKey:[NSNumber numberWithInteger:self.curButton.tag]];
    [self.curButton setTitle:NSLocalizedString(@"Change", nil) forState:UIControlStateNormal];
}
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    if ([assets count]<3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"You Should Choose 3 Pics", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
        return;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    // Allow 10 assets to be picked
    return (picker.selectedAssets.count < 3);
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
    self.originView.hidden = !self.originStructure.selected;
    self.waterProofView.hidden = !self.waterProof.selected;
    self.circuitView.hidden = !self.Circuit.selected;
    self.backFillView.hidden = !self.backFill.selected;
    self.completeView.hidden = !self.complete.selected;
}
@end
