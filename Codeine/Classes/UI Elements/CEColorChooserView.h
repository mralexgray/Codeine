
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

@property (readwrite, strong) NSColor* backgroundColor;
@property (readwrite, strong) NSColor* foregroundColor;
@property (readwrite, strong) NSColor* color;
@property (readwrite, strong) NSFont* font;
@property (readwrite, copy) NSString* title;
@property (readwrite, unsafe_unretained) id representedObject;
@property (readwrite, unsafe_unretained) id<CEColorChooserViewDelegate> delegate;

@end
