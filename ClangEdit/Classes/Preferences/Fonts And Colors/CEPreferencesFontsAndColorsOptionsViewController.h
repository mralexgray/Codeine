/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesFontsAndColorsOptionsViewController: CEViewController
{
@protected
    
    NSTextField * _fontTextField;
    NSColorWell * _generalForegroundColorWell;
    NSColorWell * _generalBackgroundColorWell;
    NSColorWell * _generalSelectionColorWell;
    NSColorWell * _generalCurrentLineColorWell;
    NSColorWell * _sourceKeywordColorWell;
    NSColorWell * _sourceCommentColorWell;
    NSColorWell * _sourceStringColorWell;
    NSColorWell * _sourcePredefinedColorWell;
    
@private
    
    RESERVERD_IVARS( CEPreferencesFontsAndColorsOptionsViewController , 5 );
}

@property( nonatomic, readwrite, assign ) IBOutlet NSTextField * fontTextField;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * generalForegroundColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * generalBackgroundColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * generalSelectionColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * generalCurrentLineColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * sourceKeywordColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * sourceCommentColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * sourceStringColorWell;
@property( nonatomic, readwrite, assign ) IBOutlet NSColorWell * sourcePredefinedColorWell;

- ( IBAction )chooseFont: ( id )sender;

@end
