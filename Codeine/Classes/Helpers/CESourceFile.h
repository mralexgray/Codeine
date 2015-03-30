
/* $Id$ */

typedef enum {
  CESourceFileLanguageNone = 0x00,
  CESourceFileLanguageC = 0x01,
  CESourceFileLanguageCPP = 0x02,
  CESourceFileLanguageObjC = 0x03,
  CESourceFileLanguageObjCPP = 0x04,
  CESourceFileLanguageHeader = 0x05
} CESourceFileLanguage;

typedef enum {
  CESourceFileLineEndingsUnknown = 0x00,
  CESourceFileLineEndingsUnix = 0x01,
  CESourceFileLineEndingsWindows = 0x02
} CESourceFileLineEndings;

@interface CESourceFile : NSObject {
@protected

  CESourceFileLanguage _language;
  NSString* _text;
  CKTranslationUnit* _translationUnit;

@private

  RESERVED_IVARS(CESourceFile, 5);
}

@property (atomic, readonly) CESourceFileLanguage language;
@property (atomic, readwrite, retain) NSString* text;
@property (atomic, readonly) CKTranslationUnit* translationUnit;

+ (id)sourceFileWithLanguage:(CESourceFileLanguage)language;
+ (id)sourceFileWithLanguage:(CESourceFileLanguage)language fromFile:(NSString*)path;
- (id)initWithLanguage:(CESourceFileLanguage)language;
- (id)initWithLanguage:(CESourceFileLanguage)language fromFile:(NSString*)path;

@end
