/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesGeneralOptionsViewController.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"

@implementation CEPreferencesGeneralOptionsViewController

@synthesize languagePopUp = _languagePopUp;
@synthesize encodingPopUp = _encodingPopUp;

- ( void )dealloc
{
    RELEASE_IVAR( _languagePopUp );
    RELEASE_IVAR( _encodingPopUp );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSArray        * encodings;
    CETextEncoding * encoding;
    
    encodings = [ CETextEncoding availableEncodings ];
    
    for( encoding in encodings )
    {
        [ _encodingPopUp addItemWithTitle: encoding.localizedName ];
        
        if( encoding.value == [ [ CEPreferences sharedInstance ] textEncoding ] )
        {
            [ _encodingPopUp selectItemWithTitle: encoding.localizedName ];
        }
    }
}

- ( IBAction )setLanguage: ( id )sender
{
    ( void )sender;
}

- ( IBAction )setEncoding: ( id )sender
{
    ( void )sender;
}

@end
