
/* $Id$ */

#import "CEWindowController.h"

@class CEFilesViewController;
@class CEEditorViewController;
@class CEDebugViewController;
@class CESourceFile;
@class CELanguageWindowController;
@class CEFileDetailsViewController;
@class CEDocument;

FOUNDATION_EXPORT NSString* const CEMainWindowControllerDocumentsArrayKey;

@interface CEMainWindowController : CEWindowController {
@protected

  CEFilesViewController* _fileViewController;
  CEEditorViewController* _editorViewController;
  CEDebugViewController* _debugViewController;
  CEFileDetailsViewController* _fileDetailsViewController;
  NSView* __weak _leftView;
  NSView* __weak _mainView;
  NSView* __weak _bottomView;
  CELanguageWindowController* _languageWindowController;
  NSPopUpButton* __weak _encodingPopUp;
  NSMutableArray* _documents;
  CEDocument* _activeDocument;
  NSSplitView* __weak _horizontalSplitView;
  NSSplitView* __weak _verticalSplitView;
  BOOL _fileBrowserHidden;
  BOOL _debugAreaHidden;
  NSSegmentedControl* __weak _viewsSegmentedControl;
  BOOL _fullScreen;

@private

  RESERVED_IVARS(CEMainWindowController, 5);
}

@property (weak, nonatomic) IBOutlet NSView* leftView;
@property (weak, nonatomic) IBOutlet NSView* mainView;
@property (weak, nonatomic) IBOutlet NSView* bottomView;
@property (weak, nonatomic) IBOutlet NSPopUpButton* encodingPopUp;
@property (weak, nonatomic, readonly) NSArray* documents;
@property (weak, nonatomic) CEDocument* activeDocument;
@property (weak, nonatomic) IBOutlet NSSplitView* horizontalSplitView;
@property (weak, nonatomic) IBOutlet NSSplitView* verticalSplitView;
@property (weak, nonatomic) IBOutlet NSSegmentedControl* viewsSegmentedControl;
@property (nonatomic, readonly) BOOL fullScreen;

- (IBAction)addBookmark:(id)sender;
- (IBAction)removeBookmark:(id)sender;
- (IBAction)clearConsole:(id)sender;
- (IBAction)openDocument:(id)sender;
- (IBAction)newDocument:(id)sender;
- (IBAction)saveDocument:(id)sender;
- (IBAction)toggleFileBrowser:(id)sender;
- (IBAction)toggleDebugArea:(id)sender;
- (IBAction)toggleViews:(id)sender;
- (IBAction)toggleLineNumbers:(id)sender;
- (IBAction)toggleSoftWrap:(id)sender;
- (IBAction)toggleInvisibleCharacters:(id)sender;
- (IBAction)toggleFullScreenMode:(id)sender;
- (IBAction)enterFullScreenMode:(id)sender;
- (IBAction)exitFullScreenMode:(id)sender;

@end
