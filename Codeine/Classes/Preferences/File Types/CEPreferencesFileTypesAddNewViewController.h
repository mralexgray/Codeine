
/* $Id$ */

#import "CEWindowController.h"
#import "CESourceFile.h"

@interface CEPreferencesFileTypesAddNewViewController : CEWindowController {
@protected

  NSTextField* __weak _textField;
  NSPopUpButton* __weak _popUpButton;
  NSString* _fileExtension;
  CESourceFileLanguage _language;

@private

  RESERVED_IVARS(CEPreferencesFileTypesAddNewViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSTextField* textField;
@property (weak, nonatomic) IBOutlet NSPopUpButton* popUpButton;
@property (readonly) NSString* fileExtension;
@property (readonly) CESourceFileLanguage language;

- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;

@end
