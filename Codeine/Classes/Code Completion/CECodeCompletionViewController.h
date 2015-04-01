
/* $Id$ */

#import "CEViewController.h"

@interface CECodeCompletionViewController : CEViewController {
@protected

  NSArray* _results;
  BOOL _cancel;
  BOOL _isOpening;
  NSTableView* __weak _tableView;

@private

  RESERVED_IVARS(CECodeCompletionViewController, 5);
}

@property (readonly) BOOL isOpening;
@property (weak, nonatomic) IBOutlet NSTableView* tableView;

- (instancetype)initWithCompletionResults:(NSArray*)results;
- (void)cancelOpening;
- (void)openInPopoverRelativeToRect:(NSRect)rect ofView:(NSView*)view preferredEdge:(NSRectEdge)edge delay:(BOOL)delay;

@end
