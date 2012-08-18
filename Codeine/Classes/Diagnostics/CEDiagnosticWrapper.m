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
    NSString * severity;
    
    severity = nil;
    
    if( _diagnostic.severity == CKDiagnosticSeverityFatal )
    {
        severity = L10N( "DiagnosticSeverityFatal" );
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityError )
    {
        severity = L10N( "DiagnosticSeverityError" );
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityWarning )
    {
        severity = L10N( "DiagnosticSeverityWarning" );
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityFatal )
    {
        severity = L10N( "DiagnosticSeverityNotice" );
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityIgnored )
    {
        severity = L10N( "DiagnosticSeverityIgnored" );
    }
    
    return [ NSString stringWithFormat: L10N( "DiagnosticMessage" ), severity, _diagnostic.line, _diagnostic.spelling ];
}

@end
