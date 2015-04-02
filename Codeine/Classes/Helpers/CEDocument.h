
/* $Id$ */

#import "CEFile.h"
#import "CESourceFile.h"

@class CEFile;


@interface CEDocument : NSObject {
@protected

  CEFile* _file;
  CESourceFile* _sourceFile;
  NSString* _name;
  NSUUID* _uuid;

@private

  RESERVED_IVARS(CEDocument, 5);
}

@property (readwrite, strong) CEFile* file;
@property (readonly) CESourceFile* sourceFile;
@property (readonly) NSString* name;
@property (weak,readonly) NSImage* icon;
@property (readonly) NSUUID* uuid;

+ (instancetype)documentWithPath:(NSString*)path;
+ (instancetype)documentWithURL:(NSURL*)url;
+ (instancetype)documentWithLanguage:(CESourceFileLanguage)language;
- (instancetype)initWithPath:(NSString*)path;
- (instancetype)initWithURL:(NSURL*)url;
- (instancetype)initWithLanguage:(CESourceFileLanguage)language;
- (void)save;
- (BOOL)save:(NSError**)error;

@end
