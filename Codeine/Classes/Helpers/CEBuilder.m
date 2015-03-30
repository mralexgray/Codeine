
/* $Id$ */

#import "CEBuilder.h"
#import "CEDocument.h"

@implementation CEBuilder

@synthesize document = _document;

+ ( id )builderWithDocument: ( CEDocument * )document
{
    return [ [ ( ( CEBuilder * )[ self alloc ] ) initWithDocument: document ] autorelease ];
}

- ( id )initWithDocument: ( CEDocument * )document
{
    if( ( self = [ self init ] ) )
    {
        _document = [ document retain ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _document );
    
    [ super dealloc ];
}

- ( BOOL )build: ( NSError ** )error
{

    
    return YES;
}

- ( BOOL )run: ( NSError ** )error
{

    
    return YES;
}

- ( BOOL )stop: ( NSError ** )error
{

    
    return YES;
}

@end
