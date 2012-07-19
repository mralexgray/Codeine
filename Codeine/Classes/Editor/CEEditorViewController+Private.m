/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorViewController+Private.h"
#import "CEPreferences.h"
#import "CEEditorLayoutManager.h"
#import "CEEditorRulerView.h"

@implementation CEEditorViewController( Private )

- ( void )updateView
{
    NSFont       * font;
    NSDictionary * selectionAttributes;
    
    _layoutManager.showInvisibles = [ [ CEPreferences sharedInstance ] showInvisibles ];
    
    font = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: [ [ CEPreferences sharedInstance ] fontSize ] ];
    
    _textView.font                = font;
    _textView.backgroundColor     = [ [ CEPreferences sharedInstance ] backgroundColor ];
    _textView.textColor           = [ [ CEPreferences sharedInstance ] foregroundColor ];
    _textView.insertionPointColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
    
    selectionAttributes =   [ NSDictionary dictionaryWithObjectsAndKeys:    [ [ CEPreferences sharedInstance ] selectionColor ],  NSBackgroundColorAttributeName,
                                                                            [ [ CEPreferences sharedInstance ] foregroundColor ], NSForegroundColorAttributeName,
                                                                            nil
                            ];
    
    [ _textView setSelectedTextAttributes: selectionAttributes ];
    
    if( [ [ CEPreferences sharedInstance ] showLineNumbers ] == YES )
    {
        {
            CEEditorRulerView * rulerView;
            
            rulerView = [ CEEditorRulerView new ];
            
            [ rulerView setClientView: _textView ];
            [ rulerView setScrollView: [ _textView enclosingScrollView ] ];
            
            [ [ _textView enclosingScrollView ] setVerticalRulerView: rulerView ];
            [ [ _textView enclosingScrollView ] setHasHorizontalRuler: NO ];
            [ [ _textView enclosingScrollView ] setHasVerticalRuler: YES ];
            [ [ _textView enclosingScrollView ] setRulersVisible: YES ];
            
            [ rulerView release ];
        }
    }
    else
    {
        [ [ _textView enclosingScrollView ] setVerticalRulerView: nil ];
        [ [ _textView enclosingScrollView ] setHasHorizontalRuler: NO ];
        [ [ _textView enclosingScrollView ] setHasVerticalRuler: NO ];
        [ [ _textView enclosingScrollView ] setRulersVisible: NO ];
}
}

@end
