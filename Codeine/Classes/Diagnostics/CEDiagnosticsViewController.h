
/* $Id$ */

#import "CEViewController.h"

@class CEDocument;
@class CEHUDView;

FOUNDATION_EXPORT NSString* const CEDiagnosticsViewControllerTableColumnIdentifierIcon;
FOUNDATION_EXPORT NSString* const CEDiagnosticsViewControllerTableColumnIdentifierLine;
FOUNDATION_EXPORT NSString* const CEDiagnosticsViewControllerTableColumnIdentifierColumn;
FOUNDATION_EXPORT NSString* const CEDiagnosticsViewControllerTableColumnIdentifierMessage;

@interface CEDiagnosticsViewController : CEViewController {
@protected

  NSTableView* _tableView;
  CEDocument* _document;
  NSTextView* _textView;
  NSMutableArray* _diagnostics;
  CEHUDView* _hud;

@private

  RESERVED_IVARS(CEDiagnosticsViewController, 5);
}

@property (nonatomic) IBOutlet NSTableView* tableView;
@property (atomic, readwrite, retain) CEDocument* document;
@property (atomic, readwrite, retain) NSTextView* textView;

@end
