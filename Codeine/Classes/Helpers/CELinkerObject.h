
/* $Id$ */

#import "CESourceFile.h"

typedef NS_OPTIONS(unsigned int, CELinkerObjectType) {
  CELinkerObjectTypeFramework = 0x00,
  CELinkerObjectTypeSharedLibrary = 0x01,
  CELinkerObjectTypeStaticLibrary = 0x02
};

@interface CELinkerObject : NSObject {
@protected

  CELinkerObjectType _type;
  CESourceFileLanguage _language;
  NSString* _path;

@private

  RESERVED_IVARS(CELinkerObject, 5);
}

@property (readonly) CELinkerObjectType type;
@property (readonly) CESourceFileLanguage language;
@property (readonly) NSString* path;
@property (weak,readonly) NSString* name;
@property (weak,readonly) NSImage* icon;

+ (NSArray*)linkerObjects;
+ (NSArray*)linkerObjectsWithType:(CELinkerObjectType)type;
+ (instancetype)linkerObjectWithPath:(NSString*)path type:(CELinkerObjectType)type;
+ (instancetype)linkerObjectWithPath:(NSString*)path type:(CELinkerObjectType)type language:(CESourceFileLanguage)language;
- (instancetype)initWithPath:(NSString*)path type:(CELinkerObjectType)type;
- (instancetype)initWithPath:(NSString*)path type:(CELinkerObjectType)type language:(CESourceFileLanguage)language;

@end
