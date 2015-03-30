
/* $Id$ */

#import "CEViewController.h"

@interface CECodeCompletionViewController : CEViewController {
@protected

  NSArray* _results;
  BOOL _cancel;
  BOOL _isOpening;
  NSTableView* _tableView;

@private

  RESERVED_IVARS(CECodeCompletionViewController, 5);
}

@property (atomic, readonly) BOOL isOpening;
@property (nonatomic) IBOutlet NSTableView* tableView;

- (id)initWithCompletionResults:(NSArray*)results;
- (void)cancelOpening;
- (void)openInPopoverRelativeToRect:(NSRect)rect ofView:(NSView*)view preferredEdge:(NSRectEdge)edge delay:(BOOL)delay;

@end
