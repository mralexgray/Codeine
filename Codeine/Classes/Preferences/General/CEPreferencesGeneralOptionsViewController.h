
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesGeneralOptionsViewController : CEViewController {
@protected

  NSPopUpButton* __weak _languagePopUp;
  NSPopUpButton* __weak _encodingPopUp;
  NSMatrix* __weak _lineEndingsMatrix;

@private

  RESERVED_IVARS(CEPreferencesGeneralOptionsViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSPopUpButton* languagePopUp;
@property (weak, nonatomic) IBOutlet NSPopUpButton* encodingPopUp;
@property (weak, nonatomic) IBOutlet NSMatrix* lineEndingsMatrix;

- (IBAction)setLanguage:(id)sender;
- (IBAction)setEncoding:(id)sender;
- (IBAction)setLineEndings:(id)sender;

@end
