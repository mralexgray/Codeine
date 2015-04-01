
/* $Id$ */

#import "CEFile.h"
#import "CESourceFile.h"

@class CEFile;
@class CEUUID;

@interface CEDocument : NSObject {
@protected

  CEFile* _file;
  CESourceFile* _sourceFile;
  NSString* _name;
  CEUUID* _uuid;

@private

  RESERVED_IVARS(CEDocument, 5);
}

@property (readwrite, strong) CEFile* file;
@property (readonly) CESourceFile* sourceFile;
@property (readonly) NSString* name;
@property (weak,readonly) NSImage* icon;
@property (readonly) CEUUID* uuid;

+ (id)documentWithPath:(NSString*)path;
+ (id)documentWithURL:(NSURL*)url;
+ (id)documentWithLanguage:(CESourceFileLanguage)language;
- (id)initWithPath:(NSString*)path;
- (id)initWithURL:(NSURL*)url;
- (id)initWithLanguage:(CESourceFileLanguage)language;
- (void)save;
- (BOOL)save:(NSError**)error;

@end
