
/* $Id$ */

#import "CEDiagnosticsViewController.h"

@interface CEDiagnosticsViewController (Private)

- (void)applicationStateDidChange:(NSNotification*)notification;
- (void)getDiagnostics;
- (void)textViewSelectionDidChange:(NSNotification*)notification;
- (void)showPopover;

@end
