/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESourceFile.h"

FOUNDATION_EXPORT NSString * const CEPreferencesNotificationValueChanged;

FOUNDATION_EXPORT NSString * const CEPreferencesKeyFontSize;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyFontName;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyGeneralForegoundColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyGeneralBackgroundColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyGeneralSelectionColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyGeneralCurrentLineColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeySourceKeywordColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeySourceCommentColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeySourceStringColor;
FOUNDATION_EXPORT NSString * const CEPreferencesKeySourcePredefinedColor;
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

@class CEColorTheme;

@interface CEPreferences: NSObject
{
@protected
    
    
    
@private
    
    RESERVERD_IVARS( CEPreferences , 5 );
}

@property( atomic, readwrite, assign ) NSString               * fontName;
@property( atomic, readwrite, assign ) CGFloat                  fontSize;
@property( atomic, readwrite, assign ) NSColor                * generalForegroundColor;
@property( atomic, readwrite, assign ) NSColor                * generalBackgroundColor;
@property( atomic, readwrite, assign ) NSColor                * generalSelectionColor;
@property( atomic, readwrite, assign ) NSColor                * generalCurrentLineColor;
@property( atomic, readwrite, assign ) NSColor                * sourceKeywordColor;
@property( atomic, readwrite, assign ) NSColor                * sourceCommentColor;
@property( atomic, readwrite, assign ) NSColor                * sourceStringColor;
@property( atomic, readwrite, assign ) NSColor                * sourcePredefinedColor;
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
@property( atomic, readonly          ) NSDictionary           * colorThemes;
@property( atomic, readonly          ) CEColorTheme           * currentColorTheme;
@property( atomic, readwrite, assign ) BOOL                     treatWarningsAsErrors;
@property( atomic, readwrite, assign ) BOOL                     showHiddenFiles;

+ ( CEPreferences * )sharedInstance;

- ( void )enableWarningFlag: ( NSString * )name;
- ( void )disableWarningFlag: ( NSString * )name;
- ( void )addObjCFramework: ( NSString * )name;
- ( void )removeObjCFramework: ( NSString * )name;
- ( void )addFileType: ( CESourceFileLanguage )type forExtension: ( NSString * )extension;
- ( void )removeFileTypeForExtension: ( NSString * )extension;
- ( void )setColorsFromColorTheme: ( CEColorTheme * )theme;

@end
