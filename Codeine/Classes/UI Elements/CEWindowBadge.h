
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

@property (readwrite, copy) NSString* title;
@property (readwrite, strong) NSColor* backgroundColor;
@property (readwrite, strong) NSColor* activeBackgroundColor;
@property (readwrite, strong) id target;
@property (readwrite, assign) SEL action;

@end
