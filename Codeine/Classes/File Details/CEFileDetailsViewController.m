
/* $Id$ */

#import "CEFileDetailsViewController.h"
#import "CEFile.h"
#import "CEBackgroundView.h"
#import "CEMainWindowController.h"
#import "CEDocument.h"

@implementation CEFileDetailsViewController

@synthesize iconView                    = _iconView, nameTextField               = _nameTextField, kindTextField               = _kindTextField, sizeTextField               = _sizeTextField, creationDateTextField       = _creationDateTextField, modificationDateTextField   = _modificationDateTextField, lastOpenedDateTextField     = _lastOpenedDateTextField, openButton                  = _openButton;

- ( void )dealloc
{
    RELEASE_IVAR( _file );
    
}

- ( void )awakeFromNib
{
    [ ( CEBackgroundView * )( self.view ) setBackgroundColor: [ NSColor whiteColor ] ];
}

- ( CEFile * )file
{
    @synchronized( self )
    {
        return _file;
    }
}

- ( void )setFile: ( CEFile * )file
{
    @synchronized( self )
    {
        if( file != _file )
        {
            
            _file     = file;
            _document = [ CEDocument documentWithPath: _file.path ];
            
            [ self view ];
            
            _iconView.image                         = _file.icon;
            _nameTextField.stringValue              = ( _file.name != nil )             ? _file.name                    : @"";
            _kindTextField.stringValue              = ( _file.kind != nil )             ? _file.kind.capitalizedString  : @"";
            _sizeTextField.stringValue              = ( _file.size != nil )             ? _file.size                    : @"";
            _creationDateTextField.stringValue      = ( _file.creationTime != nil )     ? _file.creationTime            : @"";
            _modificationDateTextField.stringValue  = ( _file.modificationTime != nil ) ? _file.modificationTime        : @"";
            _lastOpenedDateTextField.stringValue    = ( _file.lastOpenedTime != nil )   ? _file.lastOpenedTime          : @"";
            
            if( _document.sourceFile.text == nil )
            {
                [ _openButton setEnabled: NO ];
            }
            else
            {
                [ _openButton setEnabled: YES ];
            }
        }
    }
}

- ( IBAction )open: ( id )sender
{

    
    [ ( CEMainWindowController * )( self.view.window.windowController ) setActiveDocument: _document ];
}

- ( IBAction )openWithDefaultEditor: ( id )sender
{

    
    [ WORKSPACE openFile: _file.path ];
}

- ( IBAction )showInFinder: ( id )sender
{

    
    [ WORKSPACE selectFile: _file.path inFileViewerRootedAtPath: nil ];
}

- ( IBAction )preview: ( id )sender
{

    
    [ APPLICATION showQuickLookPanelForItemAtPath: _file.path sender: sender ];
}

@end
