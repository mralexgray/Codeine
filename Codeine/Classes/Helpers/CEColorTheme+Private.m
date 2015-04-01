
/* $Id$ */

#import "CEColorTheme+Private.h"

@implementation CEColorTheme (Private)

- (void)setColorFromDictionary:(NSDictionary*)dict name:(NSString*)name selector:(SEL)selector {
  CGFloat r,g,b;

  NSDictionary* colorValues = dict[name];
  r = (CGFloat)([(NSNumber*)colorValues[@"R"] doubleValue] / (CGFloat)255);
  g = (CGFloat)([(NSNumber*)colorValues[@"G"] doubleValue] / (CGFloat)255);
  b = (CGFloat)([(NSNumber*)colorValues[@"B"] doubleValue] / (CGFloat)255);

  NSColor* color = [NSColor colorWithDeviceRed:r green:g blue:b alpha:(CGFloat)1];

  [self performSelector:selector withObject:color];
}

@end
