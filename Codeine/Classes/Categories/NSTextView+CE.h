
/* $Id$ */

@interface NSTextView (CE)

- (NSUInteger)numberOfHardLines;
- (NSUInteger)numberOfSoftLines;
- (void)enableSoftWrap;
- (void)disableSoftWrap;
- (NSInteger)currentLine;
- (NSInteger)currentColumn;

@end
