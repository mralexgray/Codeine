
/* $Id$ */

@interface CEWindowBadge : NSView {
@protected

  NSString* _title;
  NSColor* _backgroundColor;
  NSColor* _activeBackgroundColor;
  NSTrackingArea* _trackingArea;
  id _target;
  SEL _action;
  BOOL _inTrackingArea;

@private

  RESERVED_IVARS(CEWindowBadge, 5);
}

@property (atomic, readwrite, copy) NSString* title;
@property (atomic, readwrite, strong) NSColor* backgroundColor;
@property (atomic, readwrite, strong) NSColor* activeBackgroundColor;
@property (atomic, readwrite, strong) id target;
@property (atomic, readwrite, assign) SEL action;

@end
