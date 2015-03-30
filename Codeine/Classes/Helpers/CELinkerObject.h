
/* $Id$ */

#import "CESourceFile.h"

typedef enum {
  CELinkerObjectTypeFramework = 0x00,
  CELinkerObjectTypeSharedLibrary = 0x01,
  CELinkerObjectTypeStaticLibrary = 0x02
} CELinkerObjectType;

@interface CELinkerObject : NSObject {
@protected

  CELinkerObjectType _type;
  CESourceFileLanguage _language;
  NSString* _path;

@private

  RESERVED_IVARS(CELinkerObject, 5);
}

@property (atomic, readonly) CELinkerObjectType type;
@property (atomic, readonly) CESourceFileLanguage language;
@property (atomic, readonly) NSString* path;
@property (weak, atomic, readonly) NSString* name;
@property (weak, atomic, readonly) NSImage* icon;

+ (NSArray*)linkerObjects;
+ (NSArray*)linkerObjectsWithType:(CELinkerObjectType)type;
+ (id)linkerObjectWithPath:(NSString*)path type:(CELinkerObjectType)type;
+ (id)linkerObjectWithPath:(NSString*)path type:(CELinkerObjectType)type language:(CESourceFileLanguage)language;
- (id)initWithPath:(NSString*)path type:(CELinkerObjectType)type;
- (id)initWithPath:(NSString*)path type:(CELinkerObjectType)type language:(CESourceFileLanguage)language;

@end
