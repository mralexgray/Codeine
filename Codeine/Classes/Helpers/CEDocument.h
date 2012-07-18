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
    
@private
    
    RESERVERD_IVARS( CEDocument, 5 );
}

@property( atomic, readonly ) CEFile        * file;
@property( atomic, readonly ) CESourceFile  * sourceFile;

+ ( id )documentWithPath: ( NSString * )path;
+ ( id )documentWithURL: ( NSURL * )url;
+ ( id )documentWithLanguage: ( CESourceFileLanguage )language;
- ( id )initWithPath: ( NSString * )path;
- ( id )initWithURL: ( NSURL * )url;
- ( id )initWithLanguage: ( CESourceFileLanguage )language;
- ( void )save;
- ( BOOL )save: ( NSError ** )error;

@end
