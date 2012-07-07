/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesGeneralOptionsViewController.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"

@implementation CEPreferencesGeneralOptionsViewController

@synthesize languagePopUp       = _languagePopUp;
@synthesize encodingPopUp       = _encodingPopUp;
@synthesize lineEndingsMatrix   = _lineEndingsMatrix;

- ( void )dealloc
{
    RELEASE_IVAR( _languagePopUp );
    RELEASE_IVAR( _encodingPopUp );
    RELEASE_IVAR( _lineEndingsMatrix );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    [ _languagePopUp selectItemWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] defaultLanguage ] ];
    [ _lineEndingsMatrix selectCellWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] lineEndings ] ];
}

- ( IBAction )setLanguage: ( id )sender
{
    CESourceFileLanguage language;
    
    ( void )sender;
    
    language = ( CESourceFileLanguage )[ _languagePopUp selectedTag ];
    
    [ [ CEPreferences sharedInstance ] setDefaultLanguage: language ];
}

- ( IBAction )setEncoding: ( id )sender
{
    CETextEncoding * encoding;
    
    ( void )sender;
    
    encoding = [ [ _encodingPopUp selectedItem ] representedObject ];
    
    [ [ CEPreferences sharedInstance ] setTextEncoding: encoding.value ];
}

- ( IBAction )setLineEndings: ( id )sender
{
    NSButtonCell * cell;
    
    ( void )sender;
    
    cell = [ _lineEndingsMatrix selectedCell ];
    
    [ [ CEPreferences sharedInstance ] setLineEndings: ( CESourceFileLineEndings )cell.tag ];
}

@end
