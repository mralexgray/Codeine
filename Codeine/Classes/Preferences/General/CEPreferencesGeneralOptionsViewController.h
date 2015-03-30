
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesGeneralOptionsViewController : CEViewController {
@protected

  NSPopUpButton* _languagePopUp;
  NSPopUpButton* _encodingPopUp;
  NSMatrix* _lineEndingsMatrix;

@private

  RESERVED_IVARS(CEPreferencesGeneralOptionsViewController, 5);
}

@property (nonatomic) IBOutlet NSPopUpButton* languagePopUp;
@property (nonatomic) IBOutlet NSPopUpButton* encodingPopUp;
@property (nonatomic) IBOutlet NSMatrix* lineEndingsMatrix;

- (IBAction)setLanguage:(id)sender;
- (IBAction)setEncoding:(id)sender;
- (IBAction)setLineEndings:(id)sender;

@end
