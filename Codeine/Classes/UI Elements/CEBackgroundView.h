
/* $Id$ */

@interface CEBackgroundView : NSView {
@protected

  NSColor* _backgroundColor;
  NSColor* _borderColor;
}

@property (atomic, readwrite, strong) NSColor* backgroundColor;
@property (atomic, readwrite, strong) NSColor* borderColor;

@end
