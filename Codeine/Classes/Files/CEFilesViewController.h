
/* $Id$ */

#import "CEViewController.h"

@class CEFilesViewItem;
@class CEMainWindowController;

@interface CEFilesViewController : CEViewController {
@protected

  NSOutlineView* __weak _outlineView;
  NSMutableArray* _rootItems;
  NSMenu* __weak _openDocumentMenu;
  NSMenu* __weak _bookmarkMenu;
  NSMenu* __weak _fsDirectoryMenu;
  NSMenu* __weak _fsFileMenu;
  CEFilesViewItem* _quickLookItem;
  CEMainWindowController* _mainWindowController;
  CEFilesViewItem* _openDocumentsItem;

@private

  RESERVED_IVARS(CEFilesViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSOutlineView* outlineView;
@property (weak, nonatomic) IBOutlet NSMenu* openDocumentMenu;
@property (weak, nonatomic) IBOutlet NSMenu* bookmarkMenu;
@property (weak, nonatomic) IBOutlet NSMenu* fsDirectoryMenu;
@property (weak, nonatomic) IBOutlet NSMenu* fsFileMenu;
@property (atomic, readwrite, weak) CEMainWindowController* mainWindowController;

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
