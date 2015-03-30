
/* $Id$ */

@class CETextEncoding;

@interface CETextEncodingPopUpButton : NSPopUpButton {
@protected

@private

  RESERVED_IVARS(CETextEncodingPopUpButton, 5);
}

- (CETextEncoding*)selectedTextEncoding;
- (NSStringEncoding)selectedStringEncoding;

@end
