#import "RS6HomeActionsCollectionViewCell.h"
#import "Constants.h"

@implementation RS6HomeActionsCollectionViewCell

- (IBAction)goToStartRequested:(id)sender {
    [NSNotificationCenter.defaultCenter postNotificationName:GoToStartRequested object:nil userInfo:nil];
}

- (IBAction)openCVRequested:(id)sender {
    [NSNotificationCenter.defaultCenter postNotificationName:OpenCVRequested object:nil userInfo:nil];
}
@end
