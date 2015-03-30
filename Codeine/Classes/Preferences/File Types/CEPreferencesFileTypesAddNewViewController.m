
/* $Id$ */

#import "CEPreferencesFileTypesAddNewViewController.h"

@implementation CEPreferencesFileTypesAddNewViewController

@synthesize textField       = _textField;
@synthesize popUpButton     = _popUpButton;
@synthesize fileExtension   = _fileExtension;
@synthesize language        = _language;


- ( IBAction )ok: ( id )sender
{
    NSString * extension;
    
    extension = [ _textField stringValue ];
    
    if( extension.length == 0 )
    {
        [ self cancel: sender ];
        
        return;
    }
    
    if( [ extension hasPrefix: @"." ] )
    {
        if( extension.length == 1 )
        {
            [ self cancel: sender ];
            
            return;
        }
        
        extension = [ extension substringFromIndex: 1 ];
    }
    
    _fileExtension = [ extension copy ];
    _language      = ( CESourceFileLanguage )[ _popUpButton selectedTag ];
    
    [ self.window.sheetParent endSheet: self.window returnCode: NSModalResponseOK ];
}

- ( IBAction )cancel: ( id )sender
{

    
    [ self.window.sheetParent endSheet: self.window returnCode: NSModalResponseCancel ];
}

@end
