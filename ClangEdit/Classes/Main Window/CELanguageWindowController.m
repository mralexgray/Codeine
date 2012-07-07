/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CELanguageWindowController.h"
#import "CEPreferences.h"

@implementation CELanguageWindowController

@synthesize language            = _language;
@synthesize lineEndings         = _lineEndings;
@synthesize encoding            = _encoding;
@synthesize languagePopUp       = _languagePopUp;
@synthesize encodingPopUp       = _encodingPopUp;
@synthesize lineEndingsMatrix   = _lineEndingsMatrix;

- ( void )dealloc
{
    RELEASE_IVAR( _languagePopUp );
    RELEASE_IVAR( _encodingPopUp );
    RELEASE_IVAR( _lineEndingsMatrix );
    RELEASE_IVAR( _encoding );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ _languagePopUp selectItemWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] defaultLanguage ] ];
    [ _lineEndingsMatrix selectCellWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] lineEndings ] ];
}

- ( IBAction )done: ( id )sender
{
    _language    = ( CESourceFileLanguage )[ _languagePopUp selectedTag ];
    _lineEndings = ( CESourceFileLineEndings )[ [ _lineEndingsMatrix selectedCell ] tag ];
    _encoding    = [ [ [ _encodingPopUp selectedItem ] representedObject ] retain ];
    
    [ self.window orderOut: sender ];
    [ APPLICATION endSheet: self.window ];
}

@end
