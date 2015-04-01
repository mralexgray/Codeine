
/* $Id$ */

@class CETextEncoding;

@interface CETextEncodingPopUpButton : NSPopUpButton {
@protected

@private

  RESERVED_IVARS(CETextEncodingPopUpButton, 5);
}

@property (readonly, strong) CETextEncoding *selectedTextEncoding;
@property (readonly) NSStringEncoding selectedStringEncoding;

@end
