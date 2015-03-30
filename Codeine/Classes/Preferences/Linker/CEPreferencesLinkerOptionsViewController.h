
/* $Id$ */

#import "CEViewController.h"
#import "CELinkerObject.h"

FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnIconIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnNameIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnPathIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnLanguageIdentifier;

@interface CEPreferencesLinkerOptionsViewController : CEViewController {
@protected

  NSTableView* __weak _frameworksTableView;
  NSTableView* __weak _sharedLibsTableView;
  NSTableView* __weak _staticLibsTableView;
  CELinkerObjectType _openPanelAllowedType;

@private

  RESERVED_IVARS(CEPreferencesLinkerOptionsViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSTableView* frameworksTableView;
@property (weak, nonatomic) IBOutlet NSTableView* sharedLibsTableView;
@property (weak, nonatomic) IBOutlet NSTableView* staticLibsTableView;

- (IBAction)addFramework:(id)sender;
- (IBAction)removeFramework:(id)sender;
- (IBAction)addSharedLib:(id)sender;
- (IBAction)removeSharedLib:(id)sender;
- (IBAction)addStaticLib:(id)sender;
- (IBAction)removeStaticLib:(id)sender;

@end
