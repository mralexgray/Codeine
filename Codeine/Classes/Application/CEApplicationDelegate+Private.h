
/* $Id$ */

#import "CEApplicationDelegate.h"

@interface CEApplicationDelegate (Private)

- (void)installApplicationSupportFiles;
- (void)firstLaunch;
- (void)windowDidClose:(NSNotification*)notification;
- (void)windowDidBecomeKey:(NSNotification*)notification;

@end
