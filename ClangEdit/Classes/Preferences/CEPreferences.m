/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferences.h"
#import "CEPreferences+Private.h"
#import "CEColorTheme.h"

#define __PREFERENCES_CHANGE_NOTIFY( __key__ )  [ ( NSNotificationCenter * )[ NSNotificationCenter defaultCenter ] postNotificationName: CEPreferencesNotificationValueChanged object: __key__ ]

static CEPreferences * __sharedInstance = nil;

NSString * const CEPreferencesNotificationValueChanged      = @"CEPreferencesNotificationValueChanged";

NSString * const CEPreferencesKeyFontName                   = @"FontName";
NSString * const CEPreferencesKeyFontSize                   = @"FontSize";
NSString * const CEPreferencesKeyGeneralForegoundColor      = @"ColorGeneralForeground";
NSString * const CEPreferencesKeyGeneralBackgroundColor     = @"ColorGeneralBackground";
NSString * const CEPreferencesKeyGeneralSelectionColor      = @"ColorGeneralSelection";
NSString * const CEPreferencesKeyGeneralCurrentLineColor    = @"ColorGeneralCurrentLine";
NSString * const CEPreferencesKeySourceKeywordColor         = @"ColorSourceKeyword";
NSString * const CEPreferencesKeySourceCommentColor         = @"ColorSourceComment";
NSString * const CEPreferencesKeySourceStringColor          = @"ColorSourceString";
NSString * const CEPreferencesKeySourcePredefinedColor      = @"ColorSourcePredefined";
NSString * const CEPreferencesKeyWarningFlags               = @"WarningFlags";
NSString * const CEPreferencesKeyWarningFlagsPresetStrict   = @"WarningFlagsPresetStrict";
NSString * const CEPreferencesKeyWarningFlagsPresetNormal   = @"WarningFlagsPresetNormal";
NSString * const CEPreferencesKeyObjCFrameworks             = @"ObjCFrameworks";
NSString * const CEPreferencesKeyFileTypes                  = @"FileTypes";
NSString * const CEPreferencesKeyFirstLaunch                = @"FirstLaunch";
NSString * const CEPreferencesKeyTextEncoding               = @"TextEncoding";
NSString * const CEPreferencesKeyDefaultLanguage            = @"DefaultLanguage";
NSString * const CEPreferencesKeyLineEndings                = @"LineEndings";
NSString * const CEPreferencesKeyShowInvisibles             = @"ShowInvisibles";
NSString * const CEPreferencesKeyAutoExpandTabs             = @"AutoExpandTabs";
NSString * const CEPreferencesKeyAutoIndent                 = @"AutoIndent";
NSString * const CEPreferencesKeyShowLineNumbers            = @"ShowLineNumbers";
NSString * const CEPreferencesKeyShowPageGuide              = @"ShowPageGuide";
NSString * const CEPreferencesKeyColorThemes                = @"ColorThemes";

@implementation CEPreferences

+ ( CEPreferences * )sharedInstance
{
    @synchronized( self )
    {
        if( __sharedInstance == nil )
        {
            __sharedInstance = [ [ super allocWithZone: NULL ] init ];
        }
    }
    
    return __sharedInstance;
}

+ ( id )allocWithZone:( NSZone * )zone
{
    ( void )zone;
    
    @synchronized( self )
    {
        return [ [ self sharedInstance ] retain ];
    }
}

- ( id )copyWithZone:( NSZone * )zone
{
    ( void )zone;
    
    return self;
}

- ( id )retain
{
    return self;
}

- ( NSUInteger )retainCount
{
    return UINT_MAX;
}

- ( oneway void )release
{}

- ( id )autorelease
{
    return self;
}

- ( id )init
{
    NSDictionary * defaults;
    
    if( ( self = [ super init ] ) )
    {
        defaults  = [ NSDictionary dictionaryWithContentsOfFile: [ [ NSBundle mainBundle ] pathForResource: @"Defaults" ofType: @"plist" ] ];
        
        [ DEFAULTS registerDefaults: defaults ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ super dealloc ];
}

- ( void )enableWarningFlag: ( NSString * )name
{
    NSMutableDictionary * flags;
    
    flags = [ [ self warningFlags ] mutableCopy ];
    
    [ flags setObject: [ NSNumber numberWithBool: YES ] forKey: name ];
    
    [ DEFAULTS setObject: [ NSDictionary dictionaryWithDictionary: flags ] forKey: CEPreferencesKeyWarningFlags ];
    [ DEFAULTS synchronize ];
    
    __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyWarningFlags );
    
    [ flags release ];
}

- ( void )disableWarningFlag: ( NSString * )name
{
    NSMutableDictionary * flags;
    
    flags = [ [ self warningFlags ] mutableCopy ];
    
    [ flags setObject: [ NSNumber numberWithBool: NO ] forKey: name ];
    
    [ DEFAULTS setObject: [ NSDictionary dictionaryWithDictionary: flags ] forKey: CEPreferencesKeyWarningFlags ];
    [ DEFAULTS synchronize ];
    
    __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyWarningFlags );
    
    [ flags release ];
}

- ( void )addObjCFramework: ( NSString * )name
{
    NSMutableArray * frameworks;
    
    frameworks = [ [ self objCFrameworks ] mutableCopy ];
    
    if( [ frameworks containsObject: name ] == NO )
    {
        [ frameworks addObject: name ];
    
        [ DEFAULTS setObject: [ NSArray arrayWithArray: frameworks ] forKey: CEPreferencesKeyObjCFrameworks ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyWarningFlags );
    }
    
    [ frameworks release ];
}

- ( void )removeObjCFramework: ( NSString * )name
{
    NSMutableArray * frameworks;
    
    frameworks = [ [ self objCFrameworks ] mutableCopy ];
    
    if( [ frameworks containsObject: name ] == YES )
    {
        [ frameworks removeObject: name ];
    
        [ DEFAULTS setObject: [ NSArray arrayWithArray: frameworks ] forKey: CEPreferencesKeyObjCFrameworks ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyWarningFlags );
    }
    
    [ frameworks release ];
}

- ( void )addFileType: ( CESourceFileLanguage )type forExtension: ( NSString * )extension
{
    NSMutableDictionary * types;
    
    types = [ [ self fileTypes ] mutableCopy ];
    
    [ types setObject: [ NSNumber numberWithUnsignedInteger: ( NSUInteger )type ] forKey: extension ];
    
    [ DEFAULTS setObject: [ NSDictionary dictionaryWithDictionary: types ] forKey: CEPreferencesKeyFileTypes ];
    [ DEFAULTS synchronize ];
        
    __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyFileTypes );
    
    [ types release ];
}

- ( void )removeFileTypeForExtension: ( NSString * )extension
{
    NSMutableDictionary * types;
    
    types = [ [ self fileTypes ] mutableCopy ];
    
    if( [ types objectForKey: extension ] != nil )
    {
        [ types removeObjectForKey: extension ];
        
        [ DEFAULTS setObject: [ NSDictionary dictionaryWithDictionary: types ] forKey: CEPreferencesKeyFileTypes ];
        [ DEFAULTS synchronize ];
            
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyFileTypes );
    }
    
    [ types release ];
}

- ( void )setColorsFromColorTheme: ( CEColorTheme * )theme
{
    self.generalForegroundColor     = theme.generalForegroundColor;
    self.generalBackgroundColor     = theme.generalBackgroundColor;
    self.generalSelectionColor      = theme.generalSelectionColor;
    self.generalCurrentLineColor    = theme.generalCurrentLineColor;
    self.sourceKeywordColor         = theme.sourceKeywordColor;
    self.sourceCommentColor         = theme.sourceCommentColor;
    self.sourceStringColor          = theme.sourceStringColor;
    self.sourcePredefinedColor      = theme.sourcePredefinedColor;
}

#pragma mark -
#pragma mark Getters

- ( NSString * )fontName
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyFontName ];
    }
}

- ( CGFloat )fontSize
{
    @synchronized( self )
    {
        return [ ( NSNumber * )[ DEFAULTS objectForKey: CEPreferencesKeyFontSize ] doubleValue ];
    }
}

- ( NSColor * )generalForegroundColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyGeneralForegoundColor ];
    }
}

- ( NSColor * )generalBackgroundColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyGeneralBackgroundColor ];
    }
}

- ( NSColor * )generalSelectionColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyGeneralSelectionColor ];
    }
}

- ( NSColor * )generalCurrentLineColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyGeneralCurrentLineColor ];
    }
}

- ( NSColor * )sourceKeywordColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeySourceKeywordColor ];
    }
}

- ( NSColor * )sourceCommentColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeySourceCommentColor ];
    }
}

- ( NSColor * )sourceStringColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeySourceStringColor ];
    }
}

- ( NSColor * )sourcePredefinedColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeySourcePredefinedColor ];
    }
}

- ( NSDictionary * )warningFlags
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyWarningFlags ];
    }
}

- ( NSDictionary * )warningFlagsPresetStrict
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyWarningFlagsPresetStrict ];
    }
}

- ( NSDictionary * )warningFlagsPresetNormal
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyWarningFlagsPresetNormal ];
    }
}

- ( NSArray * )objCFrameworks
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyObjCFrameworks ];
    }
}

- ( NSDictionary * )fileTypes
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyFileTypes ];
    }
}

- ( BOOL )firstLaunch
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyFirstLaunch ];
    }
}

- ( NSStringEncoding )textEncoding
{
    @synchronized( self )
    {
        return [ ( NSNumber * )[ DEFAULTS objectForKey: CEPreferencesKeyTextEncoding ] unsignedIntegerValue ];
    }
}

- ( CESourceFileLanguage )defaultLanguage
{
    @synchronized( self )
    {
        return ( CESourceFileLanguage )[ ( NSNumber * )[ DEFAULTS objectForKey: CEPreferencesKeyDefaultLanguage ] unsignedIntegerValue ];
    }
}

- ( CESourceFileLineEndings )lineEndings
{
    @synchronized( self )
    {
        return ( CESourceFileLineEndings )[ ( NSNumber * )[ DEFAULTS objectForKey: CEPreferencesKeyLineEndings ] unsignedIntegerValue ];
    }
}

- ( BOOL )showInvisibles
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyShowInvisibles ];
    }
}

- ( BOOL )autoExpandTabs
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyAutoExpandTabs ];
    }
}

- ( BOOL )autoIndent
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyAutoIndent ];
    }
}

- ( BOOL )showLineNumbers
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyShowLineNumbers ];
    }
}

- ( BOOL )showPageGuide
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyShowPageGuide ];
    }
}

- ( NSDictionary * )colorThemes
{
    NSDictionary        * colorThemes;
    NSDictionary        * colors;
    NSMutableDictionary * themes;
    CEColorTheme        * theme;
    NSString            * name;
    
    colorThemes = [ DEFAULTS objectForKey: CEPreferencesKeyColorThemes ];
    themes      = [ NSMutableDictionary dictionaryWithCapacity: colorThemes.count ];
    
    for( name in colorThemes )
    {
        theme  = [ CEColorTheme colorThemeWithName: name ];
        colors = [ colorThemes objectForKey: name ];
        
        theme.generalForegroundColor    = [ self colorForKey: CEPreferencesKeyGeneralForegoundColor     inDictionary: colors ];
        theme.generalBackgroundColor    = [ self colorForKey: CEPreferencesKeyGeneralBackgroundColor    inDictionary: colors ];
        theme.generalSelectionColor     = [ self colorForKey: CEPreferencesKeyGeneralSelectionColor     inDictionary: colors ];
        theme.generalCurrentLineColor   = [ self colorForKey: CEPreferencesKeyGeneralCurrentLineColor   inDictionary: colors ];
        theme.sourceKeywordColor        = [ self colorForKey: CEPreferencesKeySourceKeywordColor        inDictionary: colors ];
        theme.sourceCommentColor        = [ self colorForKey: CEPreferencesKeySourceCommentColor        inDictionary: colors ];
        theme.sourceStringColor         = [ self colorForKey: CEPreferencesKeySourceStringColor         inDictionary: colors ];
        theme.sourcePredefinedColor     = [ self colorForKey: CEPreferencesKeySourcePredefinedColor     inDictionary: colors ];
        
        [ themes setObject: theme forKey: theme.name ];
    }
    
    return themes;
}

- ( CEColorTheme * )currentColorTheme
{
    CEColorTheme * theme;
    
    theme = [ CEColorTheme colorThemeWithName: nil ];
    
    theme.generalForegroundColor    = self.generalForegroundColor;
    theme.generalBackgroundColor    = self.generalBackgroundColor;
    theme.generalSelectionColor     = self.generalSelectionColor;
    theme.generalCurrentLineColor   = self.generalCurrentLineColor;
    theme.sourceKeywordColor        = self.sourceKeywordColor;
    theme.sourceCommentColor        = self.sourceCommentColor;
    theme.sourceStringColor         = self.sourceStringColor;
    theme.sourcePredefinedColor     = self.sourcePredefinedColor;
    
    return theme;
}

#pragma mark -
#pragma mark Setters

- ( void )setFontName: ( NSString * )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: value forKey: CEPreferencesKeyFontName ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyGeneralForegoundColor );
    }
}

- ( void )setFontSize: ( CGFloat )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithDouble: value ] forKey: CEPreferencesKeyFontSize ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyFontSize );
    }
}

- ( void )setGeneralForegroundColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyGeneralForegoundColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyGeneralForegoundColor );
    }
}

- ( void )setGeneralBackgroundColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyGeneralBackgroundColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyGeneralBackgroundColor );
    }
}

- ( void )setGeneralSelectionColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyGeneralSelectionColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyGeneralSelectionColor );
    }
}

- ( void )setGeneralCurrentLineColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyGeneralCurrentLineColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyGeneralCurrentLineColor );
    }
}

- ( void )setSourceKeywordColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeySourceKeywordColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeySourceKeywordColor );
    }
}

- ( void )setSourceCommentColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeySourceCommentColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeySourceCommentColor );
    }
}

- ( void )setSourceStringColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeySourceStringColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeySourceStringColor );
    }
}

- ( void )setSourcePredefinedColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeySourcePredefinedColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeySourcePredefinedColor );
    }
}

- ( void )setFirstLaunch: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyFirstLaunch ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyFirstLaunch );
    }
}

- ( void )setTextEncoding: ( NSStringEncoding )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithUnsignedInteger: value ] forKey: CEPreferencesKeyTextEncoding ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyTextEncoding );
    }
}

- ( void )setDefaultLanguage: ( CESourceFileLanguage )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithUnsignedInteger: value ] forKey: CEPreferencesKeyDefaultLanguage ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyDefaultLanguage );
    }
}

- ( void )setLineEndings: ( CESourceFileLineEndings )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithUnsignedInteger: value ] forKey: CEPreferencesKeyLineEndings ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyLineEndings );
    }
}

- ( void )setShowInvisibles: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyShowInvisibles ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyShowInvisibles );
    }
}

- ( void )setAutoExpandTabs: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyAutoExpandTabs ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyAutoExpandTabs );
    }
}

- ( void )setAutoIndent: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyAutoIndent ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyAutoIndent );
    }
}

- ( void )setShowLineNumbers: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyShowLineNumbers ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyShowLineNumbers );
    }
}

- ( void )setShowPageGuide: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyShowPageGuide ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyShowPageGuide );
    }
}

@end
