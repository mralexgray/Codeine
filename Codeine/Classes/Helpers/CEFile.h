
/* $Id$ */

@interface CEFile : NSObject {
@protected

  NSString* _path;
  NSURL* _url;
  NSDictionary* _attributes;
  NSString* _name;
  BOOL _isDirectory;
  BOOL _isPackage;
  NSString* _kind;
  NSImage* _icon;
  NSColor* _labelColor;
  NSUInteger _bytes;
  NSString* _size;
  NSDate* _creationDate;
  NSDate* _modificationDate;
  NSDate* _lastOpenedDate;
  NSString* _creationTime;
  NSString* _modificationTime;
  NSString* _lastOpenedTime;
  NSString* _owner;
  NSString* _group;
  NSUInteger _ownerID;
  NSUInteger _groupID;
  NSUInteger _permissions;
  NSUInteger _octalPermissions;
  NSString* _humanPermissions;
  BOOL _readable;
  BOOL _writable;
  BOOL _hasPermissions;

@private

  RESERVED_IVARS(CEFile, 5);
}

@property (readonly) NSString* path;
@property (readonly) NSURL* url;
@property (weak,readonly) NSString* name;
@property (readonly) BOOL isDirectory;
@property (readonly) BOOL isPackage;
@property (weak,readonly) NSString* kind;
@property (weak,readonly) NSImage* icon;
@property (weak,readonly) NSColor* labelColor;
@property (readonly) NSUInteger bytes;
@property (weak,readonly) NSString* size;
@property (weak,readonly) NSDate* creationDate;
@property (weak,readonly) NSDate* modificationDate;
@property (weak,readonly) NSDate* lastOpenedDate;
@property (weak,readonly) NSString* creationTime;
@property (weak,readonly) NSString* modificationTime;
@property (weak,readonly) NSString* lastOpenedTime;
@property (weak,readonly) NSString* owner;
@property (weak,readonly) NSString* group;
@property (readonly) NSUInteger ownerID;
@property (readonly) NSUInteger groupID;
@property (readonly) NSUInteger permissions;
@property (readonly) NSUInteger octalPermissions;
@property (weak,readonly) NSString* humanPermissions;
@property (readonly) BOOL readable;
@property (readonly) BOOL writable;

+ (id)fileWithPath:(NSString*)path;
+ (id)fileWithURL:(NSURL*)url;
- (id)initWithPath:(NSString*)path;
- (id)initWithURL:(NSURL*)url;
- (void)refresh;

@end
