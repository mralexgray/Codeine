
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesFontsAndColorsOptionsViewController : CEViewController {
@protected

  NSTextField* _fontTextField;
  NSPopUpButton* _colorThemesPopUp;
  NSTableView* _tableView;
  NSMutableArray* _colorChooserViews;

@private

  RESERVED_IVARS(CEPreferencesFontsAndColorsOptionsViewController, 5);
}

@property (nonatomic) IBOutlet NSTextField* fontTextField;
@property (nonatomic) IBOutlet NSPopUpButton* colorThemesPopUp;
@property (nonatomic) IBOutlet NSTableView* tableView;

- (IBAction)chooseFont:(id)sender;
- (IBAction)chooseColorTheme:(id)sender;
- (IBAction)restoreDefaults:(id)sender;
- (IBAction)saveTheme:(id)sender;

@end
