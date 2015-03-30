
/* $Id$ */

#import "CEColorChooserViewDelegate.h"

@interface CEColorChooserView : NSView {
@protected

  NSColor* _backgroundColor;
  NSColor* _foregroundColor;
  NSColor* _color;
  NSFont* _font;
  NSString* _title;
  NSTextField* _textField;
  NSColorWell* _colorWell;
  id __unsafe_unretained _representedObject;
  id<CEColorChooserViewDelegate> __unsafe_unretained _delegate;

@private

  RESERVED_IVARS(CEColorChooserView, 5);
}

@property (atomic, readwrite, strong) NSColor* backgroundColor;
@property (atomic, readwrite, strong) NSColor* foregroundColor;
@property (atomic, readwrite, strong) NSColor* color;
@property (atomic, readwrite, strong) NSFont* font;
@property (atomic, readwrite, copy) NSString* title;
@property (atomic, readwrite, unsafe_unretained) id representedObject;
@property (atomic, readwrite, unsafe_unretained) id<CEColorChooserViewDelegate> delegate;

@end
