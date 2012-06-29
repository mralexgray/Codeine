/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CELanguageWindowController.h"

@implementation CELanguageWindowController

@synthesize language        = _language;
@synthesize languagePopUp   = _languagePopUp;

- ( void )dealloc
{
    RELEASE_IVAR( _languagePopUp );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{}

- ( IBAction )selectLanguage: ( id )sender
{
    _language = ( CESourceFileLanguage )[ _languagePopUp selectedTag ];
    
    [ self.window orderOut: sender ];
    [ APPLICATION endSheet: self.window ];
}

@end
