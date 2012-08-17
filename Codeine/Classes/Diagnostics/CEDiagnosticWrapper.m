/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticWrapper.h"

@implementation CEDiagnosticWrapper

@synthesize diagnostic = _diagnostic;

+ ( id )diagnosticWrapperWithDiagnostic: ( CKDiagnostic * )diagnostic
{
    return [ [ [ self alloc ] initWithDiagnostic: diagnostic ] autorelease ];
}

- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic
{
    if( ( self = [ self init ] ) )
    {
        _diagnostic = [ diagnostic retain ];
    }
    
    return self;
}

- ( id )copyWithZone: ( NSZone * )zone
{
    return [ [ [ self class ] allocWithZone: zone ] initWithDiagnostic: _diagnostic ];
}

- ( NSString * )description
{
    return [ NSString stringWithFormat: L10N( "DiagnosticMessage" ), _diagnostic.line, _diagnostic.spelling ];
}

@end
