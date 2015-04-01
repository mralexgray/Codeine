
/* $Id$ */

@class CEPreferencesWindowController;
@class CEAboutWindowController;
@class CEAlternateAboutWindowController;
@class CERegistrationWindowController;
@class CEMainWindowController;

@interface CEApplicationDelegate : NSObject<NSApplicationDelegate> {
@protected

  NSMutableArray* _mainWindowControllers;
  CEPreferencesWindowController* _preferencesWindowController;
  CEAboutWindowController* _aboutWindowController;
  CEAlternateAboutWindowController* _alternateAboutWindowController;
  CERegistrationWindowController* _registrationWindowController;
  CEMainWindowController* __weak _activeMainWindowController;

@private

  RESERVED_IVARS(CEApplicationDelegate, 5);
}

@property (weak,readonly) CEMainWindowController* activeMainWindowController;

+ (CEApplicationDelegate*)sharedInstance;
- (IBAction)showPreferencesWindow:(id)sender;
- (IBAction)showAboutWindow:(id)sender;
- (IBAction)showAlternateAboutWindow:(id)sender;
- (IBAction)showRegistrationWindow:(id)sender;
- (IBAction)newWindow:(id)sender;
- (IBAction)resetColorThemes:(id)sender;

@end
