
/* $Id$ */

#import "CEEditorViewController.h"

@interface CEEditorViewController (Private)

- (void)updateView;
- (void)selectionDidChange:(NSNotification*)notification;
- (void)showAutoCompletion;
- (void)showAutoCompletionDelayed:(BOOL)delayed;

@end
