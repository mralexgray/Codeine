
/* $Id$ */

#import "CEQuickLookItem.h"

@implementation CEQuickLookItem
{
  @protected NSString* _path;
  @private RESERVED_IVARS(CEQuickLookItem, 5);
}

+ ( instancetype )quickLookItemWithPath: ( NSString * )path
{
    return[self.alloc 
         initWithPath: path ];
}

- ( instancetype )initWithPath: ( NSString * )path
{
    if( ( self = [ self init ] ) )
    {
        if( [ FILE_MANAGER fileExistsAtPath: path ] == NO )
        {
            
            return nil;
        }
        
        _path = [ path copy ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _path );
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
