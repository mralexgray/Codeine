
/* $Id$ */

#import "CEWindowController.h"

@class CEPreferencesGeneralOptionsViewController;
@class CEPreferencesEditorOptionsViewController;
@class CEPreferencesCompilerOptionsViewController;
@class CEPreferencesLinkerOptionsViewController;
@class CEPreferencesFontsAndColorsOptionsViewController;
@class CEPreferencesFileTypesOptionsViewController;
@class CEPreferencesUserInterfaceOptionsViewController;

@interface CEPreferencesWindowController : CEWindowController {
@protected

  CEPreferencesGeneralOptionsViewController* _generalOptionsViewController;
  CEPreferencesEditorOptionsViewController* _editorOptionsViewController;
  CEPreferencesCompilerOptionsViewController* _compilerOptionsViewController;
  CEPreferencesLinkerOptionsViewController* _linkerOptionsViewController;
  CEPreferencesFontsAndColorsOptionsViewController* _fontsAndColorsOptionsViewController;
  CEPreferencesFileTypesOptionsViewController* _fileTypesOptionsViewController;
  CEPreferencesUserInterfaceOptionsViewController* _userInterfaceOptionsViewController;
  NSToolbar* _toolbar;

@private

  RESERVED_IVARS(CEPreferencesWindowController, 5);
}

@property (nonatomic) IBOutlet NSToolbar* toolbar;

- (IBAction)showGeneralOptions:(id)sender;
- (IBAction)showEditorOptions:(id)sender;
- (IBAction)showCompilerOptions:(id)sender;
- (IBAction)showLinkerOptions:(id)sender;
- (IBAction)showFontsAndColorsOptions:(id)sender;
- (IBAction)showFileTypesOptions:(id)sender;
- (IBAction)showUserInterfaceOptions:(id)sender;

@end
