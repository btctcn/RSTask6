#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@protocol PhotoDataSource <NSObject>

-(void) initPhotoSource;
@property (nonatomic, readonly, assign) NSUInteger count;
@property (nonatomic, strong, nullable) PHFetchResult<PHAsset *> *fetchResult;


@end


@interface AppDelegate : UIResponder <UIApplicationDelegate, PhotoDataSource>

@property (nullable, nonatomic, strong) UIWindow *window;
@property (nonatomic, strong, nullable) PHFetchResult<PHAsset *> *fetchResult;

@end



