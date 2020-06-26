#import "RST6PreviewController.h"
#import "AppDelegate.h"
#import "UIColor+Additions.h"

@interface RST6PreviewController ()

@end

@implementation RST6PreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [PHAssetResource assetResourcesForAsset:self.asset][0].originalFilename;
    self.navigationController.navigationBar.tintColor = [UIColor fromHex:0X101010];
    self.navigationItem.leftBarButtonItems = @[ [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed)]];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"hh:mm:ss dd:MM:yyyy";
    self.creationDateLabel.text = [dateFormatter stringFromDate:self.asset.creationDate];
    self.modificationDateLabel.text = [dateFormatter stringFromDate:self.asset.modificationDate];
    NSString *mediaType = @"unknown";
    switch (self.asset.mediaType) {
        case PHAssetMediaTypeImage:
            mediaType = @"Image";
            break;
        case PHAssetMediaTypeVideo:
            mediaType = @"Video";
            break;
        case PHAssetMediaTypeAudio:
            mediaType = @"Audio";
            break;
        default:
            break;
    }
    self.typeLabel.text = mediaType;
}

-(void)donePressed{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AppDelegate setRotationEnabled:false];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [AppDelegate setRotationEnabled:true];
}

- (IBAction)shareButtonTouched:(id)sender {
    
    PHImageManager *im = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.resizeMode = PHImageRequestOptionsResizeModeNone;
    
    [im requestImageDataForAsset:self.asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info)
     {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[imageData] applicationActivities:nil];
        // prevent sharing to gallery again
        activityVC.excludedActivityTypes = @[UIActivityTypeSaveToCameraRoll];
        if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            activityVC.popoverPresentationController.sourceView = self.shareButton;
        }
        [self presentViewController:activityVC animated:YES completion:nil];
    }];
}
@end
