
/* $Id$ */

@interface CEBackgroundView : NSView {
@protected

  NSColor* _backgroundColor;
  NSColor* _borderColor;
}

@property (atomic, readwrite, retain) NSColor* backgroundColor;
@property (atomic, readwrite, retain) NSColor* borderColor;

@end
