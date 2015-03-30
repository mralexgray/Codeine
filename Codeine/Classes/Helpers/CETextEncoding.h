
/* $Id$ */

@interface CETextEncoding : NSObject {
@protected

  NSStringEncoding _value;
  NSString* _name;

@private

  RESERVED_IVARS(CETextEncoding, 5);
}

@property (atomic, readonly) NSStringEncoding encodingValue;
@property (atomic, readonly) NSString* name;
@property (weak, atomic, readonly) NSString* localizedName;

+ (NSArray*)availableEncodings;

@end
