
/* $Id$ */

@interface CETextEncoding : NSObject {
@protected

  NSStringEncoding _value;
  NSString* _name;

@private

  RESERVED_IVARS(CETextEncoding, 5);
}

@property (readonly) NSStringEncoding encodingValue;
@property (readonly) NSString* name;
@property (weak,readonly) NSString* localizedName;

+ (NSArray*)availableEncodings;

@end
