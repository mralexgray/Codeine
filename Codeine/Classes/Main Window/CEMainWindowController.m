
/* $Id$ */

#import "CEMainWindowController.h"
#import "CEMainWindowController+Private.h"
#import "CEMainWindowController+NSOpenSavePanelDelegate.h"
#import "CEMainWindowController+NSSplitViewDelegate.h"
#import "CEEditorViewController.h"
#import "CEDebugViewController.h"
#import "CEFilesViewController.h"
#import "CEFileDetailsViewController.h"
#import "CESourceFile.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"
#import "CEQuickLookItem.h"
#import "CEWindowBadge.h"
#import "CEApplicationDelegate.h"
#import "CEHUDView.h"
#import "CEDocument.h"
#import "CEDiagnosticsViewController.h"
#import "CELanguageWindowController.h"

@interface NSView (AppKitDetails)

- (void)_addKnownSubview:(NSView*)subview;
- (void)_addKnownSubview:(NSView*)aView positioned:(NSWindowOrderingMode)place relativeTo:(NSView*)otherView;
@end

NSString* const CEMainWindowControllerDocumentsArrayKey = @"documents";

@implementation CEMainWindowController

@synthesize leftView = _leftView, mainView = _mainView, bottomView = _bottomView, encodingPopUp = _encodingPopUp, horizontalSplitView = _horizontalSplitView, verticalSplitView = _verticalSplitView, viewsSegmentedControl = _viewsSegmentedControl, fullScreen = _fullScreen;

- (instancetype)init {
  if ((self = [super init])) {
    _documents = [NSMutableArray.alloc
      initWithCapacity:10];
    _editorViewController = [CEEditorViewController new];
    _debugViewController = [CEDebugViewController new];
    _fileViewController = [CEFilesViewController new];

    _fileViewController.mainWindowController = self;
  }

  return self;
}

- (void)dealloc {
  [NOTIFICATION_CENTER removeObserver:self];

  RELEASE_IVAR(_fileViewController);
  RELEASE_IVAR(_editorViewController);
  RELEASE_IVAR(_debugViewController);
  RELEASE_IVAR(_fileDetailsViewController);
  RELEASE_IVAR(_languageWindowController);
  RELEASE_IVAR(_documents);
  RELEASE_IVAR(_activeDocument);
}

- (void)awakeFromNib {
  NSUInteger resizingMask;
  CEHUDView* editorHUD;

  resizingMask = NSViewWidthSizable | NSViewHeightSizable;

  _editorViewController.view.frame = _mainView.bounds;
  _debugViewController.view.frame = _bottomView.bounds;
  _fileViewController.view.frame = _leftView.bounds;

  _editorViewController.view.autoresizingMask = resizingMask;
  _debugViewController.view.autoresizingMask = resizingMask;
  _fileViewController.view.autoresizingMask = resizingMask;

  editorHUD = [CEHUDView.alloc initWithFrame:NSMakeRect(100, 100, 200, 50)];
  editorHUD.title = L10N("NoEditor");
  editorHUD.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;

  [_mainView addSubview:editorHUD];
  [editorHUD centerInSuperview];

  _fileViewController.view.frame = _leftView.bounds;
  _debugViewController.view.frame = _bottomView.bounds;

  [_leftView addSubview:_fileViewController.view];
  [_bottomView addSubview:_debugViewController.view];

  [self.window setContentBorderThickness:(CGFloat)29 forEdge:NSMinYEdge];

  [_viewsSegmentedControl setImage:[NSImage imageNamed:@"ShowFiles-On"] forSegment:0];
  [_viewsSegmentedControl setImage:[NSImage imageNamed:@"ShowDebugger-On"] forSegment:1];

  if ([[CEPreferences sharedInstance] fileBrowserHidden] == YES) {
    [self toggleFileBrowser:nil];
  }

  if ([[CEPreferences sharedInstance] debugAreaHidden] == YES) {
    [self toggleDebugArea:nil];
  }

  if ([[CEPreferences sharedInstance] fullScreenStyle] == CEPreferencesFullScreenStyleNative) {
    self.window.collectionBehavior |= NSWindowCollectionBehaviorFullScreenPrimary;
  } else {
    self.window.collectionBehavior &= ~NSWindowCollectionBehaviorFullScreenPrimary;
  }

  _fullScreen = (self.window.styleMask & NSFullScreenWindowMask) ? YES : NO;

  [NOTIFICATION_CENTER addObserver:self selector:@selector(preferencesDidChange:) name:CEPreferencesNotificationValueChanged object:nil];

  _horizontalSplitView.delegate = self;
  _verticalSplitView.delegate = self;

  {
    //        NSRect          badgeRect;
    //        CEWindowBadge * badge;
    //
    //        badgeRect              = NSMakeRect( self.window.frame.size.width - 230, self.window.frame.size.height - 20, 200, 20 );
    //        badge                  =[CEWindowBadge.alloc  initWithFrame: badgeRect ];
    //        badge.autoresizingMask = NSViewMaxXMargin | NSViewMinYMargin;
    //
    //        [ badge setTitle: [ NSString stringWithFormat: @"Beta version - %lu", ( unsigned long )[ [ BUNDLE objectForInfoDictionaryKey: NSBundleInfoKeyCFBundleVersion ] integerValue ] ] ];

    //        id themeFrameView = [self.window.contentView superview];
    //        [themeFrameView respondsToSelector: @selector(_addKnownSubview:positioned:relativeTo:)]
    //        ?  [themeFrameView _addKnownSubview:container positioned:NSWindowBelow relativeTo:firstSubview]
    //        :  [themeFrameView       addSubview:container positioned:NSWindowBelow relativeTo:firstSubview];
    //
    //
    //
    //        [  addSubview: badge ];
  }

  _debugViewController.diagnosticsViewController.textView = _editorViewController.textView;
}

- (void)showWindow:(id)sender {
  [super showWindow:sender];

  if (_fileBrowserHidden == NO) {
    [_horizontalSplitView setPosition:[[CEPreferences sharedInstance] fileBrowserWidth] ofDividerAtIndex:0];
  }
  if (_debugAreaHidden == NO) {
    [_verticalSplitView setPosition:_verticalSplitView.frame.size.height - [[CEPreferences sharedInstance] debugAreaHeight] ofDividerAtIndex:0];
  }

  if (_documents.count == 0) {
    dispatch_after(
      dispatch_time(DISPATCH_TIME_NOW, 250 * NSEC_PER_MSEC),
      dispatch_get_main_queue(),
      ^(void) {
                [ self newDocument: sender ];
      });
  } else {
    self.activeDocument = _documents[0];
  }
}

- (CEDocument*)activeDocument {
  @synchronized(self) {
    return _activeDocument;
  }
}

- (void)setActiveDocument:(CEDocument*)document {
  CEDocument* d;
  BOOL found;
  NSUInteger i;

  @synchronized(self) {
    [self window];

    if (document != _activeDocument) {
      RELEASE_IVAR(_activeDocument);

      [_editorViewController.view removeFromSuperview];

      _editorViewController.view.frame = _mainView.bounds;

      [_mainView addSubview:_editorViewController.view];

      found = NO;
      i = 0;

      for (d in _documents) {
        if ([document isEqual:d] == YES && document.sourceFile.text != nil) {
          found = YES;

          break;
        }

        i++;
      }

      _debugViewController.document = document;

      if (document.sourceFile.text != nil) {
        _activeDocument = document;

        if (_editorViewController.document != document) {
          _editorViewController.document = document;
        }

        if (found == NO) {
          [[self mutableArrayValueForKey:CEMainWindowControllerDocumentsArrayKey] insertObject:document atIndex:0];
        } else {
          [self mutableArrayValueForKey:CEMainWindowControllerDocumentsArrayKey][i] = document;
        }
      } else {
        if (_fileDetailsViewController == nil) {
          _fileDetailsViewController = [CEFileDetailsViewController new];
          _fileDetailsViewController.view.frame = _mainView.bounds;
          _fileDetailsViewController.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
        }

        _fileDetailsViewController.file = document.file;

        [_editorViewController.view removeFromSuperview];

        [_mainView addSubview:_fileDetailsViewController.view];
      }
    }
  }
}

- (IBAction)openDocument:(id)sender {
  NSOpenPanel* panel;

  panel = [NSOpenPanel openPanel];
  panel.allowsMultipleSelection = NO;
  panel.canChooseDirectories = NO;
  panel.canChooseFiles = YES;
  panel.canCreateDirectories = NO;
  panel.treatsFilePackagesAsDirectories = YES;
  panel.delegate = self;

  [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
            if( result != NSFileHandlingPanelOKButton )
            {
                return;
            }
            
            self.activeDocument = [ CEDocument documentWithPath: [ panel.URL path ] ];
  }];
}

- (IBAction)newDocument:(id)sender {

  [self showLanguageWindow];
}

- (IBAction)saveDocument:(id)sender {

  NSLog(@"Save document...");
}

- (IBAction)addBookmark:(id)sender {
  [_fileViewController addBookmark:sender];
}

- (IBAction)removeBookmark:(id)sender {
  [_fileViewController removeBookmark:sender];
}

- (IBAction)clearConsole:(id)sender {

  NSLog(@"Clear console...");
}

- (NSArray*)documents {
  @synchronized(self) {
    return [NSArray arrayWithArray:_documents];
  }
}

- (IBAction)toggleFileBrowser:(id)sender {
  CGRect frame;

  if (_fileBrowserHidden == NO) {
    frame = _leftView.frame;
    frame.size.width = (CGFloat)0;
    _fileBrowserHidden = YES;
    _leftView.frame = frame;

    [_viewsSegmentedControl setImage:[NSImage imageNamed:@"ShowFiles"] forSegment:0];
  } else {
    [_horizontalSplitView setPosition:[[CEPreferences sharedInstance] fileBrowserWidth] ofDividerAtIndex:0];

    _fileBrowserHidden = NO;

    [_viewsSegmentedControl setImage:[NSImage imageNamed:@"ShowFiles-On"] forSegment:0];
  }

  [[CEPreferences sharedInstance] setFileBrowserHidden:_fileBrowserHidden];
}

- (IBAction)toggleDebugArea:(id)sender {
  CGRect frame;

  if (_debugAreaHidden == NO) {
    frame = _bottomView.frame;
    frame.size.height = (CGFloat)0;
    _debugAreaHidden = YES;
    _bottomView.frame = frame;

    [_verticalSplitView setDividerStyle:NSSplitViewDividerStyleThin];
    [_viewsSegmentedControl setImage:[NSImage imageNamed:@"ShowDebugger"] forSegment:1];
  } else {
    [_verticalSplitView setDividerStyle:NSSplitViewDividerStylePaneSplitter];
    [_verticalSplitView setPosition:_verticalSplitView.frame.size.height - [[CEPreferences sharedInstance] debugAreaHeight] ofDividerAtIndex:0];

    _debugAreaHidden = NO;

    [_viewsSegmentedControl setImage:[NSImage imageNamed:@"ShowDebugger-On"] forSegment:1];
  }

  [[CEPreferences sharedInstance] setDebugAreaHidden:_debugAreaHidden];
}

- (IBAction)toggleViews:(id)sender {
  if (_viewsSegmentedControl.selectedSegment == 0) {
    [self toggleFileBrowser:sender];
  } else if (_viewsSegmentedControl.selectedSegment == 1) {
    [self toggleDebugArea:sender];
  }
}

- (IBAction)toggleLineNumbers:(id)sender {
  BOOL value;

  value = [[CEPreferences sharedInstance] showLineNumbers];

  [[CEPreferences sharedInstance] setShowLineNumbers:(value == YES) ? NO : YES];
}

- (IBAction)toggleSoftWrap:(id)sender {
  BOOL value;

  value = [[CEPreferences sharedInstance] softWrap];

  [[CEPreferences sharedInstance] setSoftWrap:(value == YES) ? NO : YES];
}

- (IBAction)toggleInvisibleCharacters:(id)sender {
  BOOL value;

  value = [[CEPreferences sharedInstance] showInvisibles];

  [[CEPreferences sharedInstance] setShowInvisibles:(value == YES) ? NO : YES];
}

- (IBAction)toggleFullScreenMode:(id)sender {
  if (_fullScreen == NO) {
    [self enterFullScreenMode:sender];
  } else {
    [self exitFullScreenMode:sender];
  }
}

- (IBAction)enterFullScreenMode:(id)sender {
  NSView* view;
  NSInteger value;
  NSDictionary* options;

  if (_fullScreen == YES) {
    return;
  }

  _fullScreen = YES;

  if ([[CEPreferences sharedInstance] fullScreenStyle] == CEPreferencesFullScreenStyleNative) {
    [self.window toggleFullScreen:sender];
  } else {
    view = (NSView*)(self.window.contentView);
    value = NSApplicationPresentationAutoHideMenuBar | NSApplicationPresentationAutoHideDock;
    options = @{NSFullScreenModeApplicationPresentationOptions: @(value)};

    [view enterFullScreenMode:self.window.screen withOptions:options];
  }
}

- (IBAction)exitFullScreenMode:x {

  if (_fullScreen == NO) return; _fullScreen = NO;

  CEPreferences.sharedInstance.fullScreenStyle == CEPreferencesFullScreenStyleNative
  ? [self.window toggleFullScreen:x]
  : [self.window.contentView exitFullScreenModeWithOptions:nil];
}

@end

