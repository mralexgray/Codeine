
/* $Id$ */

#import "CEViewController.h"

@interface CEConsoleViewController : CEViewController {
@protected

  NSTextView* __unsafe_unretained _textView;

@private

  RESERVED_IVARS(CEConsoleViewController, 5);
}

@property (unsafe_unretained, nonatomic) IBOutlet NSTextView* textView;

@end
