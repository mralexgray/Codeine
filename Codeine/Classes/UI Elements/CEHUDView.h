
/* $Id$ */

@interface CEHUDView : NSView {
@protected

  CGFloat _cornerRadius;
  NSColor* _backgroundColor1;
  NSColor* _backgroundColor2;
  NSColor* _textColor;
  NSFont* _font;
  NSString* _title;

@private

  RESERVED_IVARS(CEHUDView, 5);
}

@property (readwrite, assign) CGFloat cornerRadius;
@property (readwrite, strong) NSColor* backgroundColor1;
@property (readwrite, strong) NSColor* backgroundColor2;
@property (readwrite, strong) NSColor* textColor;
@property (readwrite, strong) NSFont* font;
@property (readwrite, copy) NSString* title;

@end
