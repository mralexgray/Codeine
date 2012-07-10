/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESourceFile.h"

FOUNDATION_EXPORT NSString * const CEPreferencesNotificationValueChanged;

FOUNDATION_EXPORT NSString * const CEPreferencesKeyFontSize;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyFontName;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyForegoundColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyBackgroundColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeySelectionColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyCurrentLineColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyKeywordColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyCommentColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyStringColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyPredefinedColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyWarningFlags;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyWarningFlagsPresetStrict;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyWarningFlagsPresetNormal;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyObjCFrameworks;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyFileTypes;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyFirstLaunch;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyTextEncoding;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyDefaultLanguage;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyLineEndings;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyShowInvisibles;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyAutoExpandTabs;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyAutoIndent;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyShowLineNumbers;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyShowPageGuide;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyColorThemes;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyTreatWarningsAsErrors;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyShowHiddenFiles;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyBookmarks;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyLinkerObjects;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyObjCLoadAll;

@class CEColorTheme;
@class CELinkerObject;

@interface CEPreferences: NSObject
{
@protected
    
    
    
@private
    
    RESERVERD_IVARS( CEPreferences, 5 );
}

@property( atomic, readwrite, assign ) NSString               * fontName;
@property( atomic, readwrite, assign ) CGFloat                  fontSize;
@property( atomic, readwrite, assign ) NSColor                * foregroundColor;
@property( atomic, readwrite, assign ) NSColor                * backgroundColor;
@property( atomic, readwrite, assign ) NSColor                * selectionColor;
@property( atomic, readwrite, assign ) NSColor                * currentLineColor;
@property( atomic, readwrite, assign ) NSColor                * keywordColor;
@property( atomic, readwrite, assign ) NSColor                * commentColor;
@property( atomic, readwrite, assign ) NSColor                * stringColor;
@property( atomic, readwrite, assign ) NSColor                * predefinedColor;
@property( atomic, readonly          ) NSDictionary           * warningFlags;
@property( atomic, readonly          ) NSDictionary           * warningFlagsPresetStrict;
@property( atomic, readonly          ) NSDictionary           * warningFlagsPresetNormal;
@property( atomic, readonly          ) NSArray                * objCFrameworks;
@property( atomic, readonly          ) NSDictionary           * fileTypes;
@property( atomic, readwrite, assign ) BOOL                     firstLaunch;
@property( atomic, readwrite, assign ) NSStringEncoding         textEncoding;
@property( atomic, readwrite, assign ) CESourceFileLanguage     defaultLanguage;
@property( atomic, readwrite, assign ) CESourceFileLineEndings  lineEndings;
@property( atomic, readwrite, assign ) BOOL                     showInvisibles;
@property( atomic, readwrite, assign ) BOOL                     autoExpandTabs;
@property( atomic, readwrite, assign ) BOOL                     autoIndent;
@property( atomic, readwrite, assign ) BOOL                     showLineNumbers;
@property( atomic, readwrite, assign ) BOOL                     showPageGuide;
@property( atomic, readonly          ) CEColorTheme           * currentColorTheme;
@property( atomic, readwrite, assign ) BOOL                     treatWarningsAsErrors;
@property( atomic, readwrite, assign ) BOOL                     showHiddenFiles;
@property( atomic, readonly          ) NSArray                * bookmarks;
@property( atomic, readonly          ) NSArray                * linkerObjects;
@property( atomic, readwrite, assign ) BOOL                     objCLoadAll;

+ ( CEPreferences * )sharedInstance;

- ( void )enableWarningFlag: ( NSString * )name;
- ( void )disableWarningFlag: ( NSString * )name;
- ( void )addObjCFramework: ( NSString * )name;
- ( void )removeObjCFramework: ( NSString * )name;
- ( void )addFileType: ( CESourceFileLanguage )type forExtension: ( NSString * )extension;
- ( void )removeFileTypeForExtension: ( NSString * )extension;
- ( void )setColorsFromColorTheme: ( CEColorTheme * )theme;
- ( void )addBookmark: ( NSString * )path;
- ( void )removeBookmark: ( NSString * )path;
- ( void )addLinkerObject: ( CELinkerObject * )object;
- ( void )removeLinkerObject: ( CELinkerObject * )object;

@end
