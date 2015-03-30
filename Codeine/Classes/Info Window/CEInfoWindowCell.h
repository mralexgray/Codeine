
/* $Id$ */

@interface CEInfoWindowCell : NSCell {
@protected

  NSView* _view;
}

@property (atomic, readwrite, strong) NSView* view;

@end
