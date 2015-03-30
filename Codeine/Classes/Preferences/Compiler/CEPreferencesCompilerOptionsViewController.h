
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerTableViewColumnDescriptionIdentifier;

@class CEMutableOrderedDictionary;

@interface CEPreferencesCompilerOptionsViewController : CEViewController {
@protected

  NSTableView* __weak _tableView;
  CEMutableOrderedDictionary* _flags;
  NSPopUpButton* __weak _warningsPresetPopUp;
  NSPopUpButton* __weak _optimizationLevelPopUp;

@private

  RESERVED_IVARS(CEPreferencesCompilerOptionsViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSTableView* tableView;
@property (weak, nonatomic) IBOutlet NSPopUpButton* warningsPresetPopUp;
@property (weak, nonatomic) IBOutlet NSPopUpButton* optimizationLevelPopUp;

- (IBAction)selectWarningsPreset:(id)sender;
- (IBAction)selectOptimizationLevel:(id)sender;

@end
