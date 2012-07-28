/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFile.h"
#import "CESourceFile.h"

@class CEFile;

@interface CEDocument: NSObject
{
@protected
    
    CEFile       * _file;
    CESourceFile * _sourceFile;
    NSString     * _name;
    
@private
    
    RESERVED_IVARS( CEDocument, 5 );
}

@property( atomic, readonly ) CEFile        * file;
@property( atomic, readonly ) CESourceFile  * sourceFile;
@property( atomic, readonly ) NSString      * name;
@property( atomic, readonly ) NSImage       * icon;

+ ( id )documentWithPath: ( NSString * )path;
+ ( id )documentWithURL: ( NSURL * )url;
+ ( id )documentWithLanguage: ( CESourceFileLanguage )language;
- ( id )initWithPath: ( NSString * )path;
- ( id )initWithURL: ( NSURL * )url;
- ( id )initWithLanguage: ( CESourceFileLanguage )language;
- ( void )save;
- ( BOOL )save: ( NSError ** )error;

@end
