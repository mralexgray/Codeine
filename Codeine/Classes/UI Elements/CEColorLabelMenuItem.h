
/* $Id$ */

@class CEColorLabelView;

@interface CEColorLabelMenuItem : NSMenuItem {
@protected

  CEColorLabelView* _view;
  NSColor* _selectedColor;

@private

  RESERVED_IVARS(CEColorLabelView, 5);
}

@property (weak, nonatomic) NSColor* selectedColor;

@end
