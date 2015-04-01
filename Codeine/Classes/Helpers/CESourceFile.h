
/* $Id$ */

typedef NS_OPTIONS(unsigned int, CESourceFileLanguage) {
  CESourceFileLanguageNone = 0x00,
  CESourceFileLanguageC = 0x01,
  CESourceFileLanguageCPP = 0x02,
  CESourceFileLanguageObjC = 0x03,
  CESourceFileLanguageObjCPP = 0x04,
  CESourceFileLanguageHeader = 0x05
};

typedef NS_OPTIONS(unsigned int, CESourceFileLineEndings) {
  CESourceFileLineEndingsUnknown = 0x00,
  CESourceFileLineEndingsUnix = 0x01,
  CESourceFileLineEndingsWindows = 0x02
};

@interface CESourceFile : NSObject {
@protected

  CESourceFileLanguage _language;
  NSString* _text;
  CKTranslationUnit* _translationUnit;

@private

  RESERVED_IVARS(CESourceFile, 5);
}

@property (readonly) CESourceFileLanguage language;
@property (readwrite, strong) NSString* text;
@property (readonly) CKTranslationUnit* translationUnit;

+ (instancetype)sourceFileWithLanguage:(CESourceFileLanguage)language;
+ (instancetype)sourceFileWithLanguage:(CESourceFileLanguage)language fromFile:(NSString*)path;
- (instancetype)initWithLanguage:(CESourceFileLanguage)language;
- (instancetype)initWithLanguage:(CESourceFileLanguage)language fromFile:(NSString*)path;

@end
