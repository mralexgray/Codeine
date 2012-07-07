/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesFontsAndColorsOptionsViewController: CEViewController
{
@protected
    
    NSTextField   * _fontTextField;
    NSColorWell   * _generalForegroundColorWell;
    NSColorWell   * _generalBackgroundColorWell;
    NSColorWell   * _generalSelectionColorWell;
    NSColorWell   * _generalCurrentLineColorWell;
    NSColorWell   * _sourceKeywordColorWell;
    NSColorWell   * _sourceCommentColorWell;
    NSColorWell   * _sourceStringColorWell;
    NSColorWell   * _sourcePredefinedColorWell;
    NSPopUpButton * _colorThemesPopUp;
    
@private
    
    RESERVERD_IVARS( CEPreferencesFontsAndColorsOptionsViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextField   * fontTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * generalForegroundColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * generalBackgroundColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * generalSelectionColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * generalCurrentLineColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * sourceKeywordColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * sourceCommentColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * sourceStringColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSColorWell   * sourcePredefinedColorWell;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton * colorThemesPopUp;

- ( IBAction )chooseFont: ( id )sender;
- ( IBAction )chooseColorTheme: ( id )sender;

@end
