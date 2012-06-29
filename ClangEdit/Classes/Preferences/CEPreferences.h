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
FOUNDATION_EXPORT NSString * const CEPreferencesKeyWarningFlagsPresetNone;
FOUNDATION_EXPORT NSString * const CEPreferencesKeyObjCFrameworks;

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
@property( atomic, readwrite, assign ) NSArray      * warningFlags;
@property( atomic, readonly          ) NSArray      * warningFlagsPresetStrict;
@property( atomic, readonly          ) NSArray      * warningFlagsPresetNormal;
@property( atomic, readonly          ) NSArray      * warningFlagsPresetNone;
@property( atomic, readwrite, assign ) NSArray      * objCFrameworks;

+ ( CEPreferences * )sharedInstance;

@end
