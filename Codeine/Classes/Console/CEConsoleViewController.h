
/* $Id$ */

#import "CEViewController.h"

@interface CEConsoleViewController : CEViewController {
@protected

  NSTextView* _textView;

@private

  RESERVED_IVARS(CEConsoleViewController, 5);
}

@property (nonatomic) IBOutlet NSTextView* textView;

@end
