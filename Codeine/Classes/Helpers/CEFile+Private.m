
/* $Id$ */

#import "CEFile+Private.h"

@implementation CEFile( Private )

- ( void )getPermissions
{
    NSUInteger        u;
    NSUInteger        g;
    NSUInteger        o;
    NSUInteger        i;
    NSUInteger        permissions;
    NSString        * humanPermissions;
    
    _owner      = _attributes[NSFileOwnerAccountName];
    _group      = _attributes[NSFileGroupOwnerAccountName];
    _ownerID    = [ ( NSNumber * )_attributes[NSFileOwnerAccountID] unsignedIntegerValue ];
    _groupID    = [ ( NSNumber * )_attributes[NSFileGroupOwnerAccountID] unsignedIntegerValue ];
    
    _permissions = [ ( NSNumber * )_attributes[NSFilePosixPermissions] unsignedIntegerValue ];
    permissions  = _permissions;
    
    u = permissions / 64;
    g = ( permissions - ( 64 * u ) ) / 8;
    o = ( permissions - ( 64 * u ) ) - ( 8 * g );
    
    _octalPermissions   = ( u * 100 ) + ( g * 10 ) + o;
    humanPermissions    = @"";
    
    for( i = 0; i < 3; i++ )
    {
        humanPermissions    = [ [ NSString stringWithFormat: @"%@%@%@ ", ( permissions & 4 ) ? @"r" : @"-", ( permissions & 2 ) ? @"w" : @"-", ( permissions & 1 ) ? @"x" : @"-" ] stringByAppendingString: humanPermissions ];
        permissions         = permissions >> 3;
    }
    
    _humanPermissions = humanPermissions;
}

@end
