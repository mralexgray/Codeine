
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerTableViewColumnFlagIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerTableViewColumnDescriptionIdentifier;

@class CEMutableOrderedDictionary;

@interface CEPreferencesCompilerOptionsViewController : CEViewController {
@protected

  NSTableView* _tableView;
  CEMutableOrderedDictionary* _flags;
  NSPopUpButton* _warningsPresetPopUp;
  NSPopUpButton* _optimizationLevelPopUp;

@private

  RESERVED_IVARS(CEPreferencesCompilerOptionsViewController, 5);
}

@property (nonatomic) IBOutlet NSTableView* tableView;
@property (nonatomic) IBOutlet NSPopUpButton* warningsPresetPopUp;
@property (nonatomic) IBOutlet NSPopUpButton* optimizationLevelPopUp;

- (IBAction)selectWarningsPreset:(id)sender;
- (IBAction)selectOptimizationLevel:(id)sender;

@end
