
/* $Id$ */

@interface CEUUID : NSObject {
@protected

  CFUUIDRef _uuid;
  NSString* _string;

@private

  RESERVED_IVARS(CEUUID, 5);
}

@property (atomic, readonly) NSString* string;

+ (id)uuid;

@end
