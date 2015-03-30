
/* $Id$ */

#import "CEWindowController.h"
#import "CESourceFile.h"

@class CETextEncoding;
@class CEBackgroundView;
@class CELicensePopUpButton;

FOUNDATION_EXPORT NSString* const CELanguageWindowControllerTableColumnIdentifierIcon;
FOUNDATION_EXPORT NSString* const CELanguageWindowControllerTableColumnIdentifierTitle;

@interface CELanguageWindowController : CEWindowController {
@protected

  CESourceFileLanguage _language;
  CESourceFileLineEndings _lineEndings;
  CETextEncoding* _encoding;
  NSPopUpButton* __weak _encodingPopUp;
  NSMatrix* __weak _lineEndingsMatrix;
  CEBackgroundView* __weak _contentView;
  NSImageView* __weak _iconView;
  NSTableView* __weak _languagesTableView;
  NSTableView* __weak _recentFilesTableView;
  CELicensePopUpButton* __weak _licensePopUp;

@private

  RESERVED_IVARS(CELanguageWindowController, 5);
}

@property (atomic, readonly) CESourceFileLanguage language;
@property (atomic, readonly) CESourceFileLineEndings lineEndings;
@property (atomic, readonly) CETextEncoding* encoding;
@property (weak, nonatomic) IBOutlet NSPopUpButton* encodingPopUp;
@property (weak, nonatomic) IBOutlet NSMatrix* lineEndingsMatrix;
@property (weak, nonatomic) IBOutlet CEBackgroundView* contentView;
@property (weak, nonatomic) IBOutlet NSImageView* iconView;
@property (weak, nonatomic) IBOutlet NSTableView* languagesTableView;
@property (weak, nonatomic) IBOutlet NSTableView* recentFilesTableView;
@property (weak, nonatomic) IBOutlet CELicensePopUpButton* licensePopUp;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
