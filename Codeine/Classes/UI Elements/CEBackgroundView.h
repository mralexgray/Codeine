
/* $Id$ */

@interface CEBackgroundView : NSView {
@protected

  NSColor* _backgroundColor;
  NSColor* _borderColor;
}

@property (readwrite, strong) NSColor* backgroundColor;
@property (readwrite, strong) NSColor* borderColor;

@end
