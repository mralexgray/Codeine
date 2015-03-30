
/* $Id$ */

#import "CEBuilder.h"
#import "CEDocument.h"

@implementation CEBuilder

@synthesize document = _document;

+ ( id )builderWithDocument: ( CEDocument * )document
{
    return [ ( ( CEBuilder * )[ self alloc ] ) initWithDocument: document ];
}

- ( id )initWithDocument: ( CEDocument * )document
{
    if( ( self = [ self init ] ) )
    {
        _document = document;
    }
    
    return self;
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
