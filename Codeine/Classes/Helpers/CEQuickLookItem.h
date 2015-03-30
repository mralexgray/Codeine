
/* $Id$ */

#import <Quartz/Quartz.h>

@interface CEQuickLookItem : NSObject<QLPreviewItem> {
@protected

  NSString* _path;

@private

  RESERVED_IVARS(CEQuickLookItem, 5);
}

+ (id)quickLookItemWithPath:(NSString*)path;
- (id)initWithPath:(NSString*)path;

@end
