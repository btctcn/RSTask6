#import "RST6PreviewController.h"
#import "AppDelegate.h"
#import "UIColor+Additions.h"

@interface RST6PreviewController ()
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation RST6PreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
}

-(void)initUI{
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
    [self updateImage];
    [self.view layoutIfNeeded];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [AppDelegate setRotationEnabled:true];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(self.asset.mediaType == PHAssetMediaTypeVideo){
        [self playVideo];
    }
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

-(void)updateImage{
    if(self.asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive){
        [self updateLivePhoto];
    }else{
        [self updateStaticImage];
    }
}

-(void) updateLivePhoto{
    PHLivePhotoRequestOptions *options = [PHLivePhotoRequestOptions new];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [PHImageManager.defaultManager requestLivePhotoForAsset:self.asset targetSize:[self targetSize] contentMode:PHImageContentModeAspectFit options:options resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
        if(!livePhoto) return;
        
        self.imageView.hidden = YES;
        self.livePhotoView.hidden = NO;
        self.livePhotoView.livePhoto = livePhoto;
        [self.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
    }];
}

-(void)updateStaticImage{
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [PHImageManager.defaultManager requestImageForAsset:self.asset targetSize:[self targetSize] contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if(!result) return;
        
        self.livePhotoView.hidden = YES;
        self.imageView.hidden = NO;
        self.imageView.image = result;
    }];
}

-(void)playVideo{
    if(self.asset.mediaType != PHAssetMediaTypeVideo) return;
    
    if(self.playerLayer && self.playerLayer.player){
        [self.playerLayer.player play];
    } else {
        PHVideoRequestOptions *options = [PHVideoRequestOptions new];
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        [PHImageManager.defaultManager requestPlayerItemForVideo:self.asset options:options resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
            if(self.playerLayer) return;
            if(!playerItem) return;
            
            AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
            AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            
            playerLayer.frame = self.contentView.bounds;
            [self.contentView.layer addSublayer:playerLayer];
            
            [player play];
                self.playerLayer = playerLayer;
        }];
    }
}

-(CGSize) targetSize{
    CGFloat scale = UIScreen.mainScreen.scale;
    return CGSizeMake(self.imageView.bounds.size.width * scale, self.imageView.bounds.size.height * scale);
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    dispatch_sync(dispatch_get_main_queue(), ^{
        PHObjectChangeDetails *details = [changeInstance changeDetailsForObject:self.asset];
        if(!details) return;
        
        self.asset = details.objectAfterChanges;
        if(details.assetContentChanged){
            [self updateImage];
            if(self.playerLayer){
                [self.playerLayer removeFromSuperlayer];
                self.playerLayer = nil;
            }
        }
    });
}

- (void)dealloc{
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

@end
