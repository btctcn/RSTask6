#import "NSIndexPath+Additions.h"

@implementation NSIndexPath (Additions)

+(NSArray <NSIndexPath*>*) nsIndexPathArrayFromNSIndexSet:(NSIndexSet*)indexSet{
    NSMutableArray *allIndexPaths = [[NSMutableArray alloc] init];
                   [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop)
                    {
                       NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
                       [allIndexPaths addObject:indexPath];
                   }];
    return allIndexPaths;
}

@end

