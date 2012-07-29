/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileDetailsViewController.h"
#import "CEFile.h"
#import "CEBackgroundView.h"
#import "CEMainWindowController.h"
#import "CEDocument.h"

@implementation CEFileDetailsViewController

@synthesize iconView                    = _iconView;
@synthesize nameTextField               = _nameTextField;
@synthesize kindTextField               = _kindTextField;
@synthesize sizeTextField               = _sizeTextField;
@synthesize creationDateTextField       = _creationDateTextField;
@synthesize modificationDateTextField   = _modificationDateTextField;
@synthesize lastOpenedDateTextField     = _lastOpenedDateTextField;
@synthesize openButton                  = _openButton;

- ( void )dealloc
{
    RELEASE_IVAR( _file );
    RELEASE_IVAR( _iconView );
    RELEASE_IVAR( _nameTextField );
    RELEASE_IVAR( _kindTextField );
    RELEASE_IVAR( _sizeTextField );
    RELEASE_IVAR( _creationDateTextField );
    RELEASE_IVAR( _modificationDateTextField );
    RELEASE_IVAR( _lastOpenedDateTextField );
    RELEASE_IVAR( _openButton );
    
    [ super dealloc ];
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
            [ _document release ];
            [ _file     release ];
            
            _file     = [ file retain ];
            _document = [ [ CEDocument documentWithPath: _file.path ] retain ];
            
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
    ( void )sender;
    
    [ ( CEMainWindowController * )( self.view.window.windowController ) setActiveDocument: _document ];
}

- ( IBAction )openWithDefaultEditor: ( id )sender
{
    ( void )sender;
    
    [ WORKSPACE openFile: _file.path ];
}

- ( IBAction )showInFinder: ( id )sender
{
    ( void )sender;
    
    [ WORKSPACE selectFile: _file.path inFileViewerRootedAtPath: nil ];
}

- ( IBAction )preview: ( id )sender
{
    ( void )sender;
    
    [ APPLICATION showQuickLookPanelForItemAtPath: _file.path sender: sender ];
}

@end
