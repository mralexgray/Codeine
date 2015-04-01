
/* $Id$ */

#import "CEViewController.h"

@class CEVerticalTabView;
@class CEConsoleViewController;
@class CEDiagnosticsViewController;
@class CEDocument;

@interface CEDebugViewController : CEViewController {
@protected

  CEVerticalTabView* __weak _tabView;
  CEConsoleViewController* _consoleViewController;
  CEDiagnosticsViewController* _diagnosticsViewController;
  CEDocument* _document;

@private

  RESERVED_IVARS(CEDebugViewController, 5);
}

@property (weak, nonatomic) IBOutlet CEVerticalTabView* tabView;
@property (readwrite, strong) CEDocument* document;
@property (readonly) CEConsoleViewController* consoleViewController;
@property (readonly) CEDiagnosticsViewController* diagnosticsViewController;

@end
