
/* $Id$ */

#import "CESourceFile.h"

FOUNDATION_EXPORT NSString* const CEPreferencesNotificationValueChanged;

FOUNDATION_EXPORT NSString* const CEPreferencesKeyFontSize;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyFontName;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyForegoundColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyBackgroundColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeySelectionColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyCurrentLineColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyInvisibleColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyKeywordColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyCommentColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyStringColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyPredefinedColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyNumberColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyProjectColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyPreprocessorColor;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyWarningFlags;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyWarningFlagsPresetStrict;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyWarningFlagsPresetNormal;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyObjCFrameworks;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyFileTypes;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyFirstLaunch;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyTextEncoding;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyDefaultLanguage;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyDefaultLicense;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyUserName;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyUserEmail;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyLineEndings;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyShowInvisibles;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyShowSpaces;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyAutoExpandTabs;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyAutoIndent;
FOUNDATION_EXPORT NSString* const CEPreferencesKeySoftWrap;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyShowLineNumbers;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyShowPageGuide;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyShowTabStops;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyHighlightCurrentLine;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyColorThemes;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyTreatWarningsAsErrors;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyShowHiddenFiles;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyBookmarks;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyLinkerObjects;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyObjCLoadAll;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyOptimizationLevel;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyFileBrowserHidden;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyDebugAreaHidden;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyFileBrowserWidth;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyDebugAreaHeight;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyDebugAreaSelectedIndex;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyTabWidth;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyPageGuideColumn;
FOUNDATION_EXPORT NSString* const CEPreferencesKeySuggestWhileTyping;
FOUNDATION_EXPORT NSString* const CEPreferencesKeySuggestWithEscape;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyIndentSoloBrace;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyIndentSoloBracket;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyIndentSoloParenthesis;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyIndentAfterBrace;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyIndentAfterBracket;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyIndentAfterParenthesis;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyInsertClosingBrace;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyInsertClosingBracket;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyInsertClosingParenteshis;
FOUNDATION_EXPORT NSString* const CEPreferencesKeySuggestDelay;
FOUNDATION_EXPORT NSString* const CEPreferencesKeyFullScreenStyle;

typedef NS_OPTIONS(unsigned int, CEPreferencesFullScreenStyle) {
  CEPreferencesFullScreenStyleNative = 0x00,
  CEPreferencesFullScreenStyleOldStyle = 0x01
};

@class CEColorTheme;
@class CELinkerObject;

@interface CEPreferences : NSObject {
@protected

@private

  RESERVED_IVARS(CEPreferences, 5);
}

@property (readwrite, weak) NSString* fontName;
@property (readwrite, assign) CGFloat fontSize;
@property (readwrite, weak) NSColor* foregroundColor;
@property (readwrite, weak) NSColor* backgroundColor;
@property (readwrite, weak) NSColor* selectionColor;
@property (readwrite, weak) NSColor* currentLineColor;
@property (readwrite, weak) NSColor* invisibleColor;
@property (readwrite, weak) NSColor* keywordColor;
@property (readwrite, weak) NSColor* commentColor;
@property (readwrite, weak) NSColor* stringColor;
@property (readwrite, weak) NSColor* predefinedColor;
@property (readwrite, weak) NSColor* numberColor;
@property (readwrite, weak) NSColor* projectColor;
@property (readwrite, weak) NSColor* preprocessorColor;
@property (weak,readonly) NSDictionary* warningFlags;
@property (weak,readonly) NSDictionary* warningFlagsPresetStrict;
@property (weak,readonly) NSDictionary* warningFlagsPresetNormal;
@property (weak,readonly) NSArray* objCFrameworks;
@property (weak,readonly) NSDictionary* fileTypes;
@property (readwrite, assign) BOOL firstLaunch;
@property (readwrite, assign) NSStringEncoding textEncoding;
@property (readwrite, assign) CESourceFileLanguage defaultLanguage;
@property (readwrite, weak) NSString* defaultLicense;
@property (readwrite, weak) NSString* userName;
@property (readwrite, weak) NSString* userEmail;
@property (readwrite, assign) CESourceFileLineEndings lineEndings;
@property (readwrite, assign) BOOL showInvisibles;
@property (readwrite, assign) BOOL showSpaces;
@property (readwrite, assign) BOOL autoExpandTabs;
@property (readwrite, assign) BOOL autoIndent;
@property (readwrite, assign) BOOL softWrap;
@property (readwrite, assign) BOOL showLineNumbers;
@property (readwrite, assign) BOOL showPageGuide;
@property (readwrite, assign) BOOL showTabStops;
@property (readwrite, assign) BOOL highlightCurrentLine;
@property (weak,readonly) CEColorTheme* currentColorTheme;
@property (readwrite, assign) BOOL treatWarningsAsErrors;
@property (readwrite, assign) BOOL showHiddenFiles;
@property (weak,readonly) NSArray* bookmarks;
@property (weak,readonly) NSArray* linkerObjects;
@property (readwrite, assign) BOOL objCLoadAll;
@property (readwrite, assign) CEOptimizationLevel optimizationLevel;
@property (readwrite, assign) BOOL fileBrowserHidden;
@property (readwrite, assign) BOOL debugAreaHidden;
@property (readwrite, assign) CGFloat fileBrowserWidth;
@property (readwrite, assign) CGFloat debugAreaHeight;
@property (readwrite, assign) NSUInteger debugAreaSelectedIndex;
@property (readwrite, assign) NSUInteger tabWidth;
@property (readwrite, assign) NSUInteger pageGuideColumn;
@property (readwrite, assign) BOOL suggestWhileTyping;
@property (readwrite, assign) BOOL suggestWithEscape;
@property (readwrite, assign) BOOL indentSoloBrace;
@property (readwrite, assign) BOOL indentSoloBracket;
@property (readwrite, assign) BOOL indentSoloParenthesis;
@property (readwrite, assign) BOOL indentAfterBrace;
@property (readwrite, assign) BOOL indentAfterBracket;
@property (readwrite, assign) BOOL indentAfterParenthesis;
@property (readwrite, assign) BOOL insertClosingBrace;
@property (readwrite, assign) BOOL insertClosingBracket;
@property (readwrite, assign) BOOL insertClosingParenteshis;
@property (readwrite, assign) CGFloat suggestDelay;
@property (readwrite, assign) CEPreferencesFullScreenStyle fullScreenStyle;

+ (CEPreferences*)sharedInstance;

- (void)enableWarningFlag:(NSString*)name;
- (void)disableWarningFlag:(NSString*)name;
- (void)addObjCFramework:(NSString*)name;
- (void)removeObjCFramework:(NSString*)name;
- (void)addFileType:(CESourceFileLanguage)type forExtension:(NSString*)extension;
- (void)removeFileTypeForExtension:(NSString*)extension;
- (void)setColorsFromColorTheme:(CEColorTheme*)theme;
- (void)addBookmark:(NSString*)path;
- (void)removeBookmark:(NSString*)path;
- (void)addLinkerObject:(CELinkerObject*)object;
- (void)removeLinkerObject:(CELinkerObject*)object;
- (void)setLanguage:(CESourceFileLanguage)language ofLinkerObject:(CELinkerObject*)object;

@end
