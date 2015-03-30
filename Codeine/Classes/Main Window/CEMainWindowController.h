
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
  NSView* _leftView;
  NSView* _mainView;
  NSView* _bottomView;
  CELanguageWindowController* _languageWindowController;
  NSPopUpButton* _encodingPopUp;
  NSMutableArray* _documents;
  CEDocument* _activeDocument;
  NSSplitView* _horizontalSplitView;
  NSSplitView* _verticalSplitView;
  BOOL _fileBrowserHidden;
  BOOL _debugAreaHidden;
  NSSegmentedControl* _viewsSegmentedControl;
  BOOL _fullScreen;

@private

  RESERVED_IVARS(CEMainWindowController, 5);
}

@property (nonatomic) IBOutlet NSView* leftView;
@property (nonatomic) IBOutlet NSView* mainView;
@property (nonatomic) IBOutlet NSView* bottomView;
@property (nonatomic) IBOutlet NSPopUpButton* encodingPopUp;
@property (nonatomic, readonly) NSArray* documents;
@property (nonatomic) CEDocument* activeDocument;
@property (nonatomic) IBOutlet NSSplitView* horizontalSplitView;
@property (nonatomic) IBOutlet NSSplitView* verticalSplitView;
@property (nonatomic) IBOutlet NSSegmentedControl* viewsSegmentedControl;
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
