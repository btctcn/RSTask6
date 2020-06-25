#import "UIApplication+Additions.h"

@implementation UIApplication (Additions)

- (BOOL)isPortraitOrientation{
    if(UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) return YES;
    return self.statusBarOrientation == UIInterfaceOrientationPortrait ||
    self.statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

@end
