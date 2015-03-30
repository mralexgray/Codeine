
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
  NSPopUpButton* _encodingPopUp;
  NSMatrix* _lineEndingsMatrix;
  CEBackgroundView* _contentView;
  NSImageView* _iconView;
  NSTableView* _languagesTableView;
  NSTableView* _recentFilesTableView;
  CELicensePopUpButton* _licensePopUp;

@private

  RESERVED_IVARS(CELanguageWindowController, 5);
}

@property (atomic, readonly) CESourceFileLanguage language;
@property (atomic, readonly) CESourceFileLineEndings lineEndings;
@property (atomic, readonly) CETextEncoding* encoding;
@property (nonatomic) IBOutlet NSPopUpButton* encodingPopUp;
@property (nonatomic) IBOutlet NSMatrix* lineEndingsMatrix;
@property (nonatomic) IBOutlet CEBackgroundView* contentView;
@property (nonatomic) IBOutlet NSImageView* iconView;
@property (nonatomic) IBOutlet NSTableView* languagesTableView;
@property (nonatomic) IBOutlet NSTableView* recentFilesTableView;
@property (nonatomic) IBOutlet CELicensePopUpButton* licensePopUp;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
