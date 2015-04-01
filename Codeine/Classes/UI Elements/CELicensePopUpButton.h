
/* $Id$ */

@interface CELicensePopUpButton : NSPopUpButton {
@protected

@private

  RESERVED_IVARS(CELicensePopUpButton, 5);
}

@property (readonly, copy) NSString *licenseName;
@property (readonly, copy) NSString *licenseText;

@end
