
/* $Id$ */

#import "CEViewController.h"

@class CEVerticalTabView;
@class CEConsoleViewController;
@class CEDiagnosticsViewController;
@class CEDocument;

@interface CEDebugViewController : CEViewController {
@protected

  CEVerticalTabView* _tabView;
  CEConsoleViewController* _consoleViewController;
  CEDiagnosticsViewController* _diagnosticsViewController;
  CEDocument* _document;

@private

  RESERVED_IVARS(CEDebugViewController, 5);
}

@property (nonatomic) IBOutlet CEVerticalTabView* tabView;
@property (atomic, readwrite, retain) CEDocument* document;
@property (atomic, readonly) CEConsoleViewController* consoleViewController;
@property (atomic, readonly) CEDiagnosticsViewController* diagnosticsViewController;

@end
