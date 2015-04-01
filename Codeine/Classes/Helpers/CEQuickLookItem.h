
/* $Id$ */

#import <Quartz/Quartz.h>

@interface CEQuickLookItem : NSObject <QLPreviewItem>

+ (instancetype) quickLookItemWithPath:(NSString*)path;
- (instancetype)          initWithPath:(NSString*)path;

@end
