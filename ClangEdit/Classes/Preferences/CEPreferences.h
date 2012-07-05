/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

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

#import "CESourceFile.h"

@interface CEPreferences: NSObject
{
@protected
    
    
    
@private
    
    RESERVERD_IVARS( CEPreferences , 5 );
}

@property( atomic, readwrite, assign ) NSString     * fontName;
@property( atomic, readwrite, assign ) CGFloat        fontSize;
@property( atomic, readwrite, assign ) NSColor      * generalForegroundColor;
@property( atomic, readwrite, assign ) NSColor      * generalBackgroundColor;
@property( atomic, readwrite, assign ) NSColor      * generalSelectionColor;
@property( atomic, readwrite, assign ) NSColor      * generalCurrentLineColor;
@property( atomic, readwrite, assign ) NSColor      * sourceKeywordColor;
@property( atomic, readwrite, assign ) NSColor      * sourceCommentColor;
@property( atomic, readwrite, assign ) NSColor      * sourceStringColor;
@property( atomic, readwrite, assign ) NSColor      * sourcePredefinedColor;
@property( atomic, readonly          ) NSDictionary * warningFlags;
@property( atomic, readonly          ) NSDictionary * warningFlagsPresetStrict;
@property( atomic, readonly          ) NSDictionary * warningFlagsPresetNormal;
@property( atomic, readonly          ) NSArray      * objCFrameworks;
@property( atomic, readonly          ) NSDictionary * fileTypes;

+ ( CEPreferences * )sharedInstance;

- ( void )enableWarningFlag: ( NSString * )name;
- ( void )disableWarningFlag: ( NSString * )name;
- ( void )addObjCFramework: ( NSString * )name;
- ( void )removeObjCFramework: ( NSString * )name;
- ( void )addFileType: ( CESourceFileLanguage )type forExtension: ( NSString * )extension;
- ( void )removeFileTypeForExtension: ( NSString * )extension;

@end
