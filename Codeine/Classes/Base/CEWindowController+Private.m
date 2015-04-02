
/* $Id$ */

#import "CEWindowController+Private.h"

@implementation CEWindowController (Private)

- (void)windowWillClose:(NSNotification*)notification {
  NSWindow* window;

  window = notification.object;

  if (window == self.window && _releaseOnWindowClose == YES) {
    //        [ self autorelease ];
  }
}

@end
