/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CESourceFile;

@interface CEBuilder: NSObject
{
@protected
    
    CESourceFile * _sourceFile;
    
@private
    
    RESERVED_IVARS( CEBuilder , 5 );
}

@property( atomic, readonly ) CESourceFile * sourceFile;

+ ( id )builderWithSourceFile: ( CESourceFile * )file;
- ( id )initWithSourceFile: ( CESourceFile * )file;
- ( BOOL )build: ( NSError ** )error;
- ( BOOL )run: ( NSError ** )error;
- ( BOOL )stop: ( NSError ** )error;

@end
