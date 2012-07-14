/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInspectorView.h"
#import "CEInspectorView+Private.h"

@implementation CEInspectorView

@synthesize detailView  = _detailView;
@synthesize nextView    = _nextView;

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ self createAndSetSubviews ];
    }
    
    return self;
}

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ self createAndSetSubviews ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _separator );
    RELEASE_IVAR( _disclosureButton );
    RELEASE_IVAR( _titleTextField );
    RELEASE_IVAR( _detailView );
    
    [ super dealloc ];
}

- ( NSString * )title
{
    @synchronized( self )
    {
        return _titleTextField.stringValue;
    }
}

- ( void )setTitle: ( NSString * )title
{
    @synchronized( self )
    {
        _titleTextField.stringValue = title;
    }
}

@end
