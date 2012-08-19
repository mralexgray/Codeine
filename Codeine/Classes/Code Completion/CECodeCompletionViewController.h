/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CECodeCompletionViewController: CEViewController
{
@protected
    
    NSArray * _results;
    BOOL      _cancel;
    BOOL      _isOpening;
    
@private
    
    RESERVED_IVARS( CECodeCompletionViewController, 5 );
}

@property( atomic, readonly ) BOOL isOpening;

- ( id )initWithCompletionResults: ( NSArray * )results;
- ( void )cancelOpening;
- ( void )openInPopoverRelativeToRect: ( NSRect )rect ofView: ( NSView * )view preferredEdge: ( NSRectEdge )edge delay: ( BOOL )delay;

@end
