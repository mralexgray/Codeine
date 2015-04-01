
/* $Id$ */

#import "CEUUID.h"

@implementation CEUUID

@synthesize string = _string;

+ ( instancetype )uuid
{
    return [ [ self class ] new ];
}

- ( instancetype )init
{
    CFStringRef str;
    
    if( ( self = [ super init ] ) )
    {
        _uuid   = CFUUIDCreate( kCFAllocatorDefault );
        str     = CFUUIDCreateString( kCFAllocatorDefault, _uuid );
        _string = (__bridge NSString*) str;
        
        if( str != NULL )
        {
            CFRelease( str );
        }
    }
    
    return self;
}

- ( void )dealloc
{
    if( _uuid != NULL )
    {
        CFRelease( _uuid );
    }
    
    
}

@end
