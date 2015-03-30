
/* $Id$ */

@interface CEInfoWindowCell : NSCell {
@protected

  NSView* _view;
}

@property (atomic, readwrite, retain) NSView* view;

@end
