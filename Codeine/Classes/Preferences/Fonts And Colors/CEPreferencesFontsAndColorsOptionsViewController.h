
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesFontsAndColorsOptionsViewController : CEViewController {
@protected

  NSTextField* __weak _fontTextField;
  NSPopUpButton* __weak _colorThemesPopUp;
  NSTableView* __weak _tableView;
  NSMutableArray* _colorChooserViews;

@private

  RESERVED_IVARS(CEPreferencesFontsAndColorsOptionsViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSTextField* fontTextField;
@property (weak, nonatomic) IBOutlet NSPopUpButton* colorThemesPopUp;
@property (weak, nonatomic) IBOutlet NSTableView* tableView;

- (IBAction)chooseFont:(id)sender;
- (IBAction)chooseColorTheme:(id)sender;
- (IBAction)restoreDefaults:(id)sender;
- (IBAction)saveTheme:(id)sender;

@end
