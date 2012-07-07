/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEColorTheme.h"

@implementation CEColorTheme

@synthesize name = _name;
@synthesize generalForegroundColor  = _generalForegroundColor;
@synthesize generalBackgroundColor  = _generalBackgroundColor;
@synthesize generalSelectionColor   = _generalSelectionColor;
@synthesize generalCurrentLineColor = _generalCurrentLineColor;
@synthesize sourceKeywordColor      = _sourceKeywordColor;
@synthesize sourceCommentColor      = _sourceCommentColor;
@synthesize sourceStringColor       = _sourceStringColor;
@synthesize sourcePredefinedColor   = _sourcePredefinedColor;

+ ( id )colorThemeWithName: ( NSString * )name
{
    return [ [ [ self alloc ] initWithName: name ] autorelease ];
}

- ( id )initWithName: ( NSString * )name
{
    if( ( self = [ self init ] ) )
    {
        _name = [ name copy ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _name );
    RELEASE_IVAR( _generalForegroundColor );
    RELEASE_IVAR( _generalBackgroundColor );
    RELEASE_IVAR( _generalSelectionColor );
    RELEASE_IVAR( _generalCurrentLineColor );
    RELEASE_IVAR( _sourceKeywordColor );
    RELEASE_IVAR( _sourceCommentColor );
    RELEASE_IVAR( _sourceStringColor );
    RELEASE_IVAR( _sourcePredefinedColor );
    
    [ super dealloc ];
}

@end
