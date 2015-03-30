
/* $Id$ */

#import "CEViewController.h"

@class CEFilesViewItem;
@class CEMainWindowController;

@interface CEFilesViewController : CEViewController {
@protected

  NSOutlineView* _outlineView;
  NSMutableArray* _rootItems;
  NSMenu* _openDocumentMenu;
  NSMenu* _bookmarkMenu;
  NSMenu* _fsDirectoryMenu;
  NSMenu* _fsFileMenu;
  CEFilesViewItem* _quickLookItem;
  CEMainWindowController* _mainWindowController;
  CEFilesViewItem* _openDocumentsItem;

@private

  RESERVED_IVARS(CEFilesViewController, 5);
}

@property (nonatomic) IBOutlet NSOutlineView* outlineView;
@property (nonatomic) IBOutlet NSMenu* openDocumentMenu;
@property (nonatomic) IBOutlet NSMenu* bookmarkMenu;
@property (nonatomic) IBOutlet NSMenu* fsDirectoryMenu;
@property (nonatomic) IBOutlet NSMenu* fsFileMenu;
@property (atomic, readwrite, assign) CEMainWindowController* mainWindowController;

- (IBAction)addBookmark:(id)sender;
- (IBAction)removeBookmark:(id)sender;
- (IBAction)menuActionOpen:(id)sender;
- (IBAction)menuActionClose:(id)sender;
- (IBAction)menuActionShowInFinder:(id)sender;
- (IBAction)menuActionOpenInDefaultEditor:(id)sender;
- (IBAction)menuActionDelete:(id)sender;
- (IBAction)menuActionRemoveBookmark:(id)sender;
- (IBAction)menuActionGetInfo:(id)sender;
- (IBAction)menuActionQuickLook:(id)sender;
- (IBAction)menuActionSetColorLabel:(id)sender;

@end
