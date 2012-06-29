/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEApplicationDelegate.h"
#import "CEApplicationDelegate+Private.h"
#import "CEMainWindowController.h"
#import "CEPreferencesWindowController.h"
#import "CEAboutWindowController.h"
#import "CEPreferences.h"

@implementation CEApplicationDelegate

+ ( CEApplicationDelegate * )sharedInstance
{
    return ( CEApplicationDelegate * )( APPLICATION.delegate );
}

- ( void )dealloc
{
    RELEASE_IVAR( _mainWindowControllers );
    RELEASE_IVAR( _preferencesWindowController );
    RELEASE_IVAR( _aboutWindowController );
    
    [ super dealloc ];
}

- ( void )applicationDidFinishLaunching: ( NSNotification * )notification
{
    NSArray * warningFlags;
    
    ( void )notification;
    
    [ self installApplicationSupportFiles ];
    [ CEPreferences sharedInstance ];
    
    warningFlags = [ [ CEPreferences sharedInstance ] warningFlags ];
    
    if( warningFlags == nil || warningFlags.count == 0 )
    {
        [ [ CEPreferences sharedInstance ] setWarningFlags: [ [ CEPreferences sharedInstance ] warningFlagsPresetStrict ] ];
    }
    
    _mainWindowControllers = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
    
    [ self newDocument: nil ];
}

- ( IBAction )showPreferencesWindow: ( id )sender
{
    ( void )sender;
    
    if( _preferencesWindowController == nil )
    {
        _preferencesWindowController = [ CEPreferencesWindowController new ];
    }
    
    [ APPLICATION runModalForWindow: _preferencesWindowController.window ];
}

- ( IBAction )showAboutWindow: ( id )sender
{
    ( void )sender;
    
    if( _aboutWindowController == nil )
    {
        _aboutWindowController = [ CEAboutWindowController new ];
    }
    
    [ _aboutWindowController.window center ];
    [ _aboutWindowController showWindow: sender ];
    [ _aboutWindowController.window makeKeyAndOrderFront: sender ];
}

- ( IBAction )newDocument: ( id )sender
{
    CEMainWindowController * controller;
    
    controller = [ CEMainWindowController new ];
    
    [ _mainWindowControllers addObject: controller ];
    [ controller autorelease ];
    
    [ controller.window center ];
    [ controller showWindow: sender ];
    [ controller.window makeKeyAndOrderFront: sender ];
}

@end
