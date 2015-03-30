
/* $Id$ */

#import "CEColorLabelViewDelegate.h"

@interface CEColorLabelView : NSView {
@protected

  NSArray* _colors;
  NSArray* _labels;
  NSMutableArray* _tracking;
  NSColor* _selectedColor;
  NSUInteger _trackingColorIndex;
  NSUInteger _selectedColorIndex;
  id<CEColorLabelViewDelegate> _delegate;

@private

  RESERVED_IVARS(CEColorLabelView, 5);
}

@property (atomic, readwrite, retain) NSColor* selectedColor;
@property (atomic, readwrite, assign) id<CEColorLabelViewDelegate> delegate;

@end
