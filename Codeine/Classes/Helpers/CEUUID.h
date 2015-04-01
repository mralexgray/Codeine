
/* $Id$ */

@interface CEUUID : NSObject {
@protected

  CFUUIDRef _uuid;
  NSString* __weak _string;

@private

  RESERVED_IVARS(CEUUID, 5);
}

@property (weak,readonly) NSString* string;

+ (id)uuid;

@end
