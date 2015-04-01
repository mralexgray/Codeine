
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

@property (readwrite, strong) NSTextView* textView;
@property (weak, nonatomic) IBOutlet NSTextField* messageTextField;
@property (weak, nonatomic) IBOutlet NSImageView* iconView;

- (instancetype)initWithDiagnostic:(CKDiagnostic*)diagnostic;

@end
