/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileDetailsViewController.h"
#import "CEFile.h"
#import "CEBackgroundView.h"

@implementation CEFileDetailsViewController

@synthesize iconView                    = _iconView;
@synthesize nameTextField               = _nameTextField;
@synthesize kindTextField               = _kindTextField;
@synthesize sizeTextField               = _sizeTextField;
@synthesize creationDateTextField       = _creationDateTextField;
@synthesize modificationDateTextField   = _modificationDateTextField;
@synthesize lastOpenedDateTextField     = _lastOpenedDateTextField;

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
            [ _file release ];
            
            _file = [ file retain ];
            
            [ self view ];
            
            _iconView.image                         = _file.icon;
            _nameTextField.stringValue              = _file.name;
            _kindTextField.stringValue              = _file.kind;
            _sizeTextField.stringValue              = _file.size;
            _creationDateTextField.stringValue      = _file.creationTime;
            _modificationDateTextField.stringValue  = _file.modificationTime;
            _lastOpenedDateTextField.stringValue    = _file.lastOpenedTime;
        }
    }
}

- ( IBAction )showInFinder: ( id )sender
{
    ( void )sender;
    
    [ WORKSPACE selectFile: _file.path inFileViewerRootedAtPath: nil ];
}

- ( IBAction )openWithDefaultEditor: ( id )sender
{
    ( void )sender;
    
    [ WORKSPACE openFile: _file.path ];
}

- ( IBAction )preview: ( id )sender
{
    ( void )sender;
    
    [ APPLICATION showQuickLookPanelForItemAtPath: _file.path sender: sender ];
}

@end
