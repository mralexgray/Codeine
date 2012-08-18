/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFixItViewController.h"

@implementation CEFixItViewController

@synthesize textView          = _textView;
@synthesize lineTextField     = _lineTextField;
@synthesize columnTextField   = _columnTextField;
@synthesize messageTextField  = _messageTextField;
@synthesize iconView          = _iconView;
@synthesize button            = _button;

- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic
{
    if( ( self = [ self init ] ) )
    {
        _diagnostic = [ diagnostic retain ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _diagnostic );
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _lineTextField );
    RELEASE_IVAR( _columnTextField );
    RELEASE_IVAR( _messageTextField );
    RELEASE_IVAR( _iconView );
    RELEASE_IVAR( _button );
    
    [ super dealloc ];
}

- ( void )awakeFromNib
{
    NSString * severity;
    NSRect     frame;
    
    [ _lineTextField     setStringValue: @"" ];
    [ _columnTextField   setStringValue: @"" ];
    [ _messageTextField  setStringValue: @"" ];
    
    [ _lineTextField   setStringValue: [ NSString stringWithFormat: L10N( "DiagnosticLine" ),   _diagnostic.line ] ];
    [ _columnTextField setStringValue: [ NSString stringWithFormat: L10N( "DiagnosticColumn" ), _diagnostic.column ] ];
    
    severity = nil;
    
    if( _diagnostic.severity == CKDiagnosticSeverityFatal )
    {
        severity = L10N( "DiagnosticSeverityFatal" );
        
        [ _iconView setImage: [ NSImage imageNamed: @"Error" ] ];
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityError )
    {
        severity = L10N( "DiagnosticSeverityError" );
        
        [ _iconView setImage: [ NSImage imageNamed: @"Error" ] ];
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityWarning )
    {
        severity = L10N( "DiagnosticSeverityWarning" );
        
        [ _iconView setImage: [ NSImage imageNamed: @"Warning" ] ];
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityFatal )
    {
        severity = L10N( "DiagnosticSeverityNotice" );
        
        [ _iconView setImage: [ NSImage imageNamed: @"Notice" ] ];
    }
    else if( _diagnostic.severity == CKDiagnosticSeverityIgnored )
    {
        severity = L10N( "DiagnosticSeverityIgnored" );
        
        [ _iconView setImage: [ NSImage imageNamed: @"Notice" ] ];
    }
    
    [ _messageTextField setStringValue: [ NSString stringWithFormat: L10N( "DiagnosticMessageFixItPopover" ), severity, _diagnostic.spelling ] ];
    [ _messageTextField sizeToFit ];
    
    frame = self.view.frame;
    
    if( _messageTextField.frame.size.width < 400 )
    {
        frame.size.width = ( CGFloat )400;
    }
    else
    {
        frame.size.width = _messageTextField.frame.origin.x + _messageTextField.frame.size.width + ( CGFloat )20;
    }
    
    if( _diagnostic.fixIts.count == 0 )
    {
        [ _button setEnabled: NO ];
        [ _button removeFromSuperview ];
        
        frame.size.height -= _button.frame.size.height;
    }
    
    self.view.frame = frame;
}

- ( IBAction )fix: ( id )sender
{
    CKFixIt * fixit;
    NSRange   range;
    
    ( void )sender;
    
    if( _diagnostic.fixIts.count == 0 )
    {
        return;
    }
    
    fixit           = [ _diagnostic.fixIts objectAtIndex: 0 ];
    range           = _diagnostic.range;
    range.location += range.length;
    
    [ _textView replaceCharactersInRange: range withString: fixit.string ];
}

@end
