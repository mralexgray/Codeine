/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEBuilder.h"
#import "CESourceFile.h"

@implementation CEBuilder

@synthesize sourceFile = _sourceFile;

+ ( id )builderWithSourceFile: ( CESourceFile * )file
{
    return [ [ [ self alloc ] initWithSourceFile: file ] autorelease ];
}

- ( id )initWithSourceFile: ( CESourceFile * )file
{
    if( ( self = [ self init ] ) )
    {
        _sourceFile = [ file retain ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _sourceFile );
    
    [ super dealloc ];
}

- ( BOOL )build: ( NSError ** )error
{
    ( void )error;
    
    return YES;
}

- ( BOOL )run: ( NSError ** )error
{
    ( void )error;
    
    return YES;
}

- ( BOOL )stop: ( NSError ** )error
{
    ( void )error;
    
    return YES;
}

@end
