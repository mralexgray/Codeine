/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowController.h"
#import "CEInfoWindowController+Private.h"
#import "CEInfoWindowController+NSOutlineViewDataSource.h"
#import "CEInfoWindowController+NSOutlineViewDelegate.h"

@implementation CEInfoWindowController

@synthesize path                    = _path;
@synthesize outlineView             = _outlineView;
@synthesize infoView                = _infoView;
@synthesize generalLabelView        = _generalLabelView;
@synthesize iconLabelView           = _iconLabelView;
@synthesize permissionsLabelView    = _permissionsLabelView;
@synthesize generalView             = _generalView;
@synthesize iconView                = _iconView;
@synthesize permissionsView         = _permissionsView;

- ( id )initWithPath: ( NSString * )path
{
    if( ( self = [ self init ] ) )
    {
        if( [ FILE_MANAGER fileExistsAtPath: path ] == NO )
        {
            [ self release ];
            
            return nil;
        }
        
        _path = [ path copy ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _path );
    RELEASE_IVAR( _outlineView );
    RELEASE_IVAR( _infoView );
    RELEASE_IVAR( _generalLabelView );
    RELEASE_IVAR( _iconLabelView );
    RELEASE_IVAR( _permissionsLabelView );
    RELEASE_IVAR( _generalView );
    RELEASE_IVAR( _iconView );
    RELEASE_IVAR( _permissionsView );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    self.window.title = _path.lastPathComponent;
    
    _outlineView.delegate         = self;
    _outlineView.dataSource       = self;
    _outlineView.intercellSpacing = CGSizeMake( ( CGFloat )0, ( CGFloat )0 );
    
    [ self resizeWindow: NO ];
}

@end
