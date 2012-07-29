/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEApplicationDelegate+Private.h"
#import "CEPreferences.h"
#import "CEColorTheme.h"
#import "CEMainWindowController.h"

@implementation CEApplicationDelegate( Private )

- ( void )installApplicationSupportFiles
{
    NSString * path;
    
    {
        NSString * templatesBundlePath;
        NSString * templatesPath;
        
        path = [ FILE_MANAGER applicationSupportDirectory ];
        
        if( path == nil )
        {
            return;
        }
        
        templatesBundlePath = [ BUNDLE pathForResource: @"Templates" ofType: nil ];
        templatesPath       = [ path stringByAppendingPathComponent: [ templatesBundlePath lastPathComponent ] ];
        
        if( [ FILE_MANAGER fileExistsAtPath: templatesPath ] == NO )
        {
            [ FILE_MANAGER copyItemAtPath: templatesBundlePath toPath: templatesPath error: NULL ];
        }
    }
    
    {
        NSString * themesBundlePath;
        NSString * themesPath;
        
        path = [ FILE_MANAGER applicationSupportDirectory ];
        
        if( path == nil )
        {
            return;
        }
        
        themesBundlePath = [ BUNDLE pathForResource: @"Themes" ofType: nil ];
        themesPath       = [ path stringByAppendingPathComponent: [ themesBundlePath lastPathComponent ] ];
        
        if( [ FILE_MANAGER fileExistsAtPath: themesPath ] == NO )
        {
            [ FILE_MANAGER copyItemAtPath: themesBundlePath toPath: themesPath error: NULL ];
        }
    }
}

- ( void )firstLaunch
{
    if( [ [ CEPreferences sharedInstance ] firstLaunch ] == NO )
    {
        return;
    }
    
    [ [ CEPreferences sharedInstance ] setTextEncoding: NSUTF8StringEncoding ];
    
    {
        NSDictionary * warningFlags;
        NSString     * warningFlag;
        NSNumber     * warningFlagValue;
        
        warningFlags = [ [ CEPreferences sharedInstance ] warningFlags ];
        
        if( warningFlags == nil || warningFlags.count == 0 )
        {
            warningFlags = [ [ CEPreferences sharedInstance ] warningFlagsPresetNormal ];
            
            for( warningFlag in warningFlags )
            {
                warningFlagValue = ( NSNumber * )[ warningFlags objectForKey: warningFlag ];
                
                if( [ warningFlagValue boolValue ] == YES )
                {
                    [ [ CEPreferences sharedInstance ] enableWarningFlag: warningFlag ];
                }
                else
                {
                    [ [ CEPreferences sharedInstance ] disableWarningFlag: warningFlag ];
                }
            }
        }
    }
    
    {
        CEColorTheme * theme;
        
        theme = [ CEColorTheme defaultColorThemeWithName: @"Xcode" ];
        
        [ [ CEPreferences sharedInstance ] setColorsFromColorTheme: theme ];
    }
}

- ( void )windowDidClose: ( NSNotification * )notification
{
    NSWindow           * window;
    NSWindowController * controller;
    
    window      = [ notification object ];
    controller  = window.windowController;
    
    if( [ controller isKindOfClass: [ CEMainWindowController class ] ] == YES )
    {
        [ _mainWindowControllers removeObject: controller ];
    }
}

- ( void )windowDidBecomeKey: ( NSNotification * )notification
{
    NSWindow           * window;
    NSWindowController * controller;
    
    window      = [ notification object ];
    controller  = window.windowController;
    
    if( [ controller isKindOfClass: [ CEMainWindowController class ] ] == YES )
    {
        [ controller retain ];
        
        RELEASE_IVAR( _activeMainWindowController );
        
        _activeMainWindowController = ( CEMainWindowController * )controller;
    }
}

@end
