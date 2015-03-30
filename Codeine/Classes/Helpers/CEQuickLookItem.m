
/* $Id$ */

#import "CEQuickLookItem.h"

@implementation CEQuickLookItem

+ ( id )quickLookItemWithPath: ( NSString * )path
{
    return [ [ [ self alloc ] initWithPath: path ] autorelease ];
}

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
    
    [ super dealloc ];
}

- ( NSString * )previewItemTitle
{
    return [ FILE_MANAGER displayNameAtPath: _path ];
}

- ( NSURL * )previewItemURL
{
    return [ NSURL fileURLWithPath: _path ];
}

@end
