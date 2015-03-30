
/* $Id$ */

#import "CEWindowController.h"
#import "CESourceFile.h"

@interface CEPreferencesFileTypesAddNewViewController : CEWindowController {
@protected

  NSTextField* _textField;
  NSPopUpButton* _popUpButton;
  NSString* _fileExtension;
  CESourceFileLanguage _language;

@private

  RESERVED_IVARS(CEPreferencesFileTypesAddNewViewController, 5);
}

@property (nonatomic) IBOutlet NSTextField* textField;
@property (nonatomic) IBOutlet NSPopUpButton* popUpButton;
@property (atomic, readonly) NSString* fileExtension;
@property (atomic, readonly) CESourceFileLanguage language;

- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;

@end
