
/* $Id$ */

@import AppKit;

@interface NSTextView (CE)

@property (readonly) NSUInteger numberOfHardLines, numberOfSoftLines;
@property (readonly)  NSInteger currentLine, currentColumn;

- (void)enableSoftWrap;
- (void)disableSoftWrap;

@end
