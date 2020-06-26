#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (Additions)

+(NSArray <NSIndexPath*>*) nsIndexPathArrayFromNSIndexSet:(NSIndexSet*)indexSet;
+(NSArray <NSIndexPath*>*) nsIndexPathSectionArrayFromNSIndexSet:(NSIndexSet*)indexSet;

@end

NS_ASSUME_NONNULL_END
