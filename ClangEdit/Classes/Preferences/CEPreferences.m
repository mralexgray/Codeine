/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferences.h"
#import "CEPreferences+Private.h"
#import "CEColorTheme.h"
#import "CELinkerObject.h"

#define __PREFERENCES_CHANGE_NOTIFY( __key__ )  [ ( NSNotificationCenter * )[ NSNotificationCenter defaultCenter ] postNotificationName: CEPreferencesNotificationValueChanged object: __key__ ]

static CEPreferences * __sharedInstance = nil;

NSString * const CEPreferencesNotificationValueChanged      = @"CEPreferencesNotificationValueChanged";

NSString * const CEPreferencesKeyFontName                   = @"FontName";
NSString * const CEPreferencesKeyFontSize                   = @"FontSize";
NSString * const CEPreferencesKeyForegoundColor             = @"ForegroundColor";
NSString * const CEPreferencesKeyBackgroundColor            = @"BackgroundColor";
NSString * const CEPreferencesKeySelectionColor             = @"SelectionColor";
NSString * const CEPreferencesKeyCurrentLineColor           = @"CurrentLineColor";
NSString * const CEPreferencesKeyKeywordColor               = @"KeywordColor";
NSString * const CEPreferencesKeyCommentColor               = @"CommentColor";
NSString * const CEPreferencesKeyStringColor                = @"StringColor";
NSString * const CEPreferencesKeyPredefinedColor            = @"PredefinedColor";
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
NSString * const CEPreferencesKeyTreatWarningsAsErrors      = @"TreatWarningsAsErrors";
NSString * const CEPreferencesKeyShowHiddenFiles            = @"ShowHiddenFiles";
NSString * const CEPreferencesKeyBookmarks                  = @"Bookmarks";
NSString * const CEPreferencesKeyLinkerObjects              = @"LinkerObjects";
NSString * const CEPreferencesKeyObjCLoadAll                = @"ObjCLoadAll";

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
    self.foregroundColor     = theme.foregroundColor;
    self.backgroundColor     = theme.backgroundColor;
    self.selectionColor      = theme.selectionColor;
    self.currentLineColor    = theme.currentLineColor;
    self.keywordColor        = theme.keywordColor;
    self.commentColor        = theme.commentColor;
    self.stringColor         = theme.stringColor;
    self.predefinedColor     = theme.predefinedColor;
}

- ( void )addBookmark: ( NSString * )path
{
    NSMutableArray * bookmarks;
    
    bookmarks = [ self.bookmarks mutableCopy ];
    
    if( [ bookmarks containsObject: path ] == NO )
    {
        [ bookmarks addObject: path ];
        [ DEFAULTS setObject: [ NSArray arrayWithArray: bookmarks ] forKey: CEPreferencesKeyBookmarks ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyBookmarks );
    }
    
    [ bookmarks release ];
}

- ( void )removeBookmark: ( NSString * )path
{
    NSMutableArray * bookmarks;
    
    bookmarks = [ self.bookmarks mutableCopy ];
    
    if( [ bookmarks containsObject: path ] == YES )
    {
        [ bookmarks removeObject: path ];
        [ DEFAULTS setObject: [ NSArray arrayWithArray: bookmarks ] forKey: CEPreferencesKeyBookmarks ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyBookmarks );
    }
    
    [ bookmarks release ];
}

- ( void )addLinkerObject: ( CELinkerObject * )object
{
    NSArray            * allObjects;
    NSMutableArray     * objects;
    NSDictionary       * objectDict;
    NSDictionary       * dict;
    NSString           * path;
    CELinkerObjectType   type;
    CESourceFileLanguage language;
    BOOL                 found;
    
    allObjects  = self.linkerObjects;
    objects     = [ self.linkerObjects mutableCopy ];
    found       = NO;
    
    for( objectDict in allObjects )
    {
        type     = ( CELinkerObjectType )[ ( NSNumber * )[ objectDict valueForKey: @"Type" ] integerValue ];
        language = ( CESourceFileLanguage )[ ( NSNumber * )[ objectDict valueForKey: @"Language" ] integerValue ];
        path     = [ objectDict valueForKey: @"Path" ];
        
        if
        (
               type     == object.type
            && language == object.language
            && [ path isEqualToString: object.path ]
        )
        {
            found = YES;
            
            break;
        }
    }
    
    if( found == NO )
    {
        dict = [ NSDictionary dictionaryWithObjectsAndKeys: object.path,                                        @"Path",
                                                            [ NSNumber numberWithInteger: object.type ],        @"Type",
                                                            [ NSNumber numberWithInteger: object.language ],    @"Language",
                                                            nil
               ];
        
        [ objects addObject: dict ];
        [ DEFAULTS setObject: [ NSArray arrayWithArray: objects ] forKey: CEPreferencesKeyLinkerObjects ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyLinkerObjects );
    }
    
    [ objects release ];
}

- ( void )removeLinkerObject: ( CELinkerObject * )object
{
    NSArray            * allObjects;
    NSMutableArray     * objects;
    NSDictionary       * objectDict;
    NSString           * path;
    CELinkerObjectType   type;
    CESourceFileLanguage language;
    NSUInteger           i;
    BOOL                 found;
    
    allObjects  = self.linkerObjects;
    objects     = [ self.linkerObjects mutableCopy ];
    i           = 0;
    found       = NO;
    
    for( objectDict in allObjects )
    {
        type     = ( CELinkerObjectType )[ ( NSNumber * )[ objectDict valueForKey: @"Type" ] integerValue ];
        language = ( CESourceFileLanguage )[ ( NSNumber * )[ objectDict valueForKey: @"Language" ] integerValue ];
        path     = [ objectDict valueForKey: @"Path" ];
        
        if
        (
               type     == object.type
            && language == object.language
            && [ path isEqualToString: object.path ]
        )
        {
            found = YES;
            
            break;
        }
        
        i++;
    }
    
    if( found == YES )
    {
        [ objects removeObjectAtIndex: i ];
        [ DEFAULTS setObject: [ NSArray arrayWithArray: objects ] forKey: CEPreferencesKeyLinkerObjects ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyLinkerObjects );
    }
    
    [ objects release ];
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

- ( NSColor * )foregroundColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyForegoundColor ];
    }
}

- ( NSColor * )backgroundColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyBackgroundColor ];
    }
}

- ( NSColor * )selectionColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeySelectionColor ];
    }
}

- ( NSColor * )currentLineColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyCurrentLineColor ];
    }
}

- ( NSColor * )keywordColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyKeywordColor ];
    }
}

- ( NSColor * )commentColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyCommentColor ];
    }
}

- ( NSColor * )stringColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyStringColor ];
    }
}

- ( NSColor * )predefinedColor
{
    @synchronized( self )
    {
        return [ self colorForKey: CEPreferencesKeyPredefinedColor ];
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

- ( CEColorTheme * )currentColorTheme
{
    CEColorTheme * theme;
    
    theme = [ CEColorTheme colorThemeWithName: nil ];
    
    theme.foregroundColor    = self.foregroundColor;
    theme.backgroundColor    = self.backgroundColor;
    theme.selectionColor     = self.selectionColor;
    theme.currentLineColor   = self.currentLineColor;
    theme.keywordColor       = self.keywordColor;
    theme.commentColor       = self.commentColor;
    theme.stringColor        = self.stringColor;
    theme.predefinedColor    = self.predefinedColor;
    
    return theme;
}

- ( BOOL )treatWarningsAsErrors
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyTreatWarningsAsErrors ];
    }
}

- ( BOOL )showHiddenFiles
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyShowHiddenFiles ];
    }
}

- ( NSArray * )bookmarks
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyBookmarks ];
    }
}

- ( NSArray * )linkerObjects
{
    @synchronized( self )
    {
        return [ DEFAULTS objectForKey: CEPreferencesKeyLinkerObjects ];
    }
}

- ( BOOL )objCLoadAll
{
    @synchronized( self )
    {
        return [ DEFAULTS boolForKey: CEPreferencesKeyObjCLoadAll ];
    }
}

#pragma mark -
#pragma mark Setters

- ( void )setFontName: ( NSString * )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: value forKey: CEPreferencesKeyFontName ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyFontName );
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

- ( void )setForegroundColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyForegoundColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyForegoundColor );
    }
}

- ( void )setBackgroundColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyBackgroundColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyBackgroundColor );
    }
}

- ( void )setSelectionColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeySelectionColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeySelectionColor );
    }
}

- ( void )setCurrentLineColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyCurrentLineColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyCurrentLineColor );
    }
}

- ( void )setKeywordColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyKeywordColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyKeywordColor );
    }
}

- ( void )setCommentColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyCommentColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyCommentColor );
    }
}

- ( void )setStringColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyStringColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyStringColor );
    }
}

- ( void )setPredefinedColor: ( NSColor * )value
{
    @synchronized( self )
    {
        [ self setColor: value forKey: CEPreferencesKeyPredefinedColor ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyPredefinedColor );
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

- ( void )setTreatWarningsAsErrors: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyTreatWarningsAsErrors ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyTreatWarningsAsErrors );
    }
}

- ( void )setShowHiddenFiles: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyShowHiddenFiles ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyShowHiddenFiles );
    }
}

- ( void )setObjCLoadAll: ( BOOL )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: [ NSNumber numberWithBool: value ] forKey: CEPreferencesKeyObjCLoadAll ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyObjCLoadAll );
    }
}

@end
