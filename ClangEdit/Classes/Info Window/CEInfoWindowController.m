/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowController.h"
#import "CEInspectorView.h"

@implementation CEInfoWindowController

@synthesize path            = _path;
@synthesize generalView     = _generalView;
@synthesize iconView        = _iconView;
@synthesize permissionsView = _permissionsView;
@synthesize smallIconView   = _smallIconView;
@synthesize largeIconView   = _largeIconView;

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
    RELEASE_IVAR( _generalView );
    RELEASE_IVAR( _iconView );
    RELEASE_IVAR( _permissionsView );
    RELEASE_IVAR( _smallIconView );
    RELEASE_IVAR( _largeIconView );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSImage  * icon;
    NSRect     rect;
    CGImageRef cgImage;
    
    icon    = [ [ NSWorkspace sharedWorkspace ] iconForFile: _path ];
    rect    = NSMakeRect( ( CGFloat )0, ( CGFloat )0, ( CGFloat )512, ( CGFloat )512 );
    cgImage = [ icon CGImageForProposedRect: &rect context: nil hints: nil ];
    icon    = [ [ [ NSImage alloc ] initWithCGImage: cgImage size: NSMakeSize( ( CGFloat )512, ( CGFloat )512 ) ] autorelease ];
    
    self.window.title       = _path.lastPathComponent;
    _generalView.title      = L10N( "General" );
    _iconView.title         = L10N( "Preview" );
    _permissionsView.title  = L10N( "Permissions" );
    
    [ _smallIconView setImage: icon ];
    [ _largeIconView setImage: icon ];
}

@end
