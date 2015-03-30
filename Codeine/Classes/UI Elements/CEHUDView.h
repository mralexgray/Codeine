
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

@property (atomic, readwrite, assign) CGFloat cornerRadius;
@property (atomic, readwrite, strong) NSColor* backgroundColor1;
@property (atomic, readwrite, strong) NSColor* backgroundColor2;
@property (atomic, readwrite, strong) NSColor* textColor;
@property (atomic, readwrite, strong) NSFont* font;
@property (atomic, readwrite, copy) NSString* title;

@end
