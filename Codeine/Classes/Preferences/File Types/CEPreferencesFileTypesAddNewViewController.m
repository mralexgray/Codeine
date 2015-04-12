
/* $Id$ */

#import "CEPreferencesFileTypesAddNewViewController.h"

@implementation CEPreferencesFileTypesAddNewViewController

@synthesize textField       = _textField, popUpButton     = _popUpButton, fileExtension   = _fileExtension, language        = _language;


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
