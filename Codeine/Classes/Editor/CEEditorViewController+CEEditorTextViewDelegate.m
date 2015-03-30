
/* $Id$ */

#import "CEEditorViewController+CEEditorTextViewDelegate.h"
#import "CEEditorViewController+Private.h"
#import "CECodeCompletionViewController.h"

@implementation CEEditorViewController( CEEditorTextViewDelegate )

- ( BOOL )textView: ( CEEditorTextView * )textView complete: ( id )sender
{
    BOOL show;
    


    
    show = YES;
    
    if( _codeCompletionViewController != nil )
    {
        if( _codeCompletionViewController.isOpening == NO )
        {
            show = NO;
        }
        
        [ _codeCompletionViewController cancelOpening ];
        [ _codeCompletionViewController closePopover ];
        
        RELEASE_IVAR( _codeCompletionViewController );
    }
    
    if( show == YES )
    {
        [ self showAutoCompletionDelayed: NO ];
    }
    
    return YES;
}

@end
