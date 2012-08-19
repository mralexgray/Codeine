/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEDiagnosticWrapper: NSObject < NSCopying >
{
@protected
    
    CKDiagnostic * _diagnostic;
    
@private
    
    RESERVED_IVARS( CEDiagnostic, 5 );
}

@property( atomic, readonly ) CKDiagnostic * diagnostic;

+ ( id )diagnosticWrapperWithDiagnostic: ( CKDiagnostic * )diagnostic;
- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic;

@end