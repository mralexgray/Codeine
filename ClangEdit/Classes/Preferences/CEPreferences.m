/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferences.h"
#import "CEPreferences+Private.h"

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
    ( void )name;
}

- ( void )disableWarningFlag: ( NSString * )name
{
    ( void )name;
}

- ( void )addObjCFramework: ( NSString * )name
{
    ( void )name;
}

- ( void )removeObjCFramework: ( NSString * )name
{
    ( void )name;
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
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyGeneralForegoundColor );
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

- ( void )setWarningFlags: ( NSDictionary * )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: value forKey: CEPreferencesKeyWarningFlags ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyWarningFlags );
    }
}

- ( void )setObjCFrameworks: ( NSArray * )value
{
    @synchronized( self )
    {
        [ DEFAULTS setObject: value forKey: CEPreferencesKeyObjCFrameworks ];
        [ DEFAULTS synchronize ];
        
        __PREFERENCES_CHANGE_NOTIFY( CEPreferencesKeyObjCFrameworks );
    }
}

@end
