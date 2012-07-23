/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEAboutWindowController.h"

@implementation CEAboutWindowController

@synthesize versionTextField = _versionTextField;

- ( void )dealloc
{
    RELEASE_IVAR( _versionTextField );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSString * version;
    NSString * build;
    NSString * versionString;
    
    version = [ [ NSBundle mainBundle ] objectForInfoDictionaryKey: NSBundleInfoKeyCFBundleShortVersionString ];
    build   = [ [ NSBundle mainBundle ] objectForInfoDictionaryKey: NSBundleInfoKeyCFBundleVersion ];
    
    
    versionString = [ NSString stringWithFormat:  L10N( "AppVersion" ), version, [ build uppercaseString ] ];
    
    [ _versionTextField setStringValue: versionString ];
}

@end
