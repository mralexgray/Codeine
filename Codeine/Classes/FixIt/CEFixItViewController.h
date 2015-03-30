
/* $Id$ */

#import "CEViewController.h"

@interface CEFixItViewController : CEViewController {
@protected

  CKDiagnostic* _diagnostic;
  NSTextView* _textView;
  NSTextField* __weak _messageTextField;
  NSImageView* __weak _iconView;

@private

  RESERVED_IVARS(CEFixItViewController, 5);
}

@property (atomic, readwrite, strong) NSTextView* textView;
@property (weak, nonatomic) IBOutlet NSTextField* messageTextField;
@property (weak, nonatomic) IBOutlet NSImageView* iconView;

- (id)initWithDiagnostic:(CKDiagnostic*)diagnostic;

@end
