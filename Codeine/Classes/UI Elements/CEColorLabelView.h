
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
  id<CEColorLabelViewDelegate> __unsafe_unretained _delegate;

@private

  RESERVED_IVARS(CEColorLabelView, 5);
}

@property (readwrite, strong) NSColor* selectedColor;
@property (readwrite, unsafe_unretained) id<CEColorLabelViewDelegate> delegate;

@end
