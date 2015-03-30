
/* $Id$ */

#import "CEPreferencesGeneralOptionsViewController.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"

@implementation CEPreferencesGeneralOptionsViewController

@synthesize languagePopUp       = _languagePopUp;
@synthesize encodingPopUp       = _encodingPopUp;
@synthesize lineEndingsMatrix   = _lineEndingsMatrix;


- ( void )awakeFromNib
{
    [ _languagePopUp selectItemWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] defaultLanguage ] ];
    [ _lineEndingsMatrix selectCellWithTag: ( NSInteger )[ [ CEPreferences sharedInstance ] lineEndings ] ];
}

- ( IBAction )setLanguage: ( id )sender
{
    CESourceFileLanguage language;
    

    
    language = ( CESourceFileLanguage )[ _languagePopUp selectedTag ];
    
    [ [ CEPreferences sharedInstance ] setDefaultLanguage: language ];
}

- ( IBAction )setEncoding: ( id )sender
{
    CETextEncoding * encoding;
    

    
    encoding = [ [ _encodingPopUp selectedItem ] representedObject ];
    
    [ [ CEPreferences sharedInstance ] setTextEncoding: encoding.encodingValue ];
}

- ( IBAction )setLineEndings: ( id )sender
{
    NSButtonCell * cell;
    

    
    cell = [ _lineEndingsMatrix selectedCell ];
    
    [ [ CEPreferences sharedInstance ] setLineEndings: ( CESourceFileLineEndings )cell.tag ];
}

@end
