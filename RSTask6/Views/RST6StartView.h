#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RST6StartView : UIView 
-(void)initView;
-(void)startAnimations;
-(void)stopAnimations;
@property(nonatomic, copy) void (^startButtonPressedHandler)(void);
@end

NS_ASSUME_NONNULL_END
