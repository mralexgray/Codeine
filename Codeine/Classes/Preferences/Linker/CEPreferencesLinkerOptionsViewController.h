
/* $Id$ */

#import "CEViewController.h"
#import "CELinkerObject.h"

FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnIconIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnNameIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnPathIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesLinkerOptionsViewControllerTableViewColumnLanguageIdentifier;

@interface CEPreferencesLinkerOptionsViewController : CEViewController {
@protected

  NSTableView* _frameworksTableView;
  NSTableView* _sharedLibsTableView;
  NSTableView* _staticLibsTableView;
  CELinkerObjectType _openPanelAllowedType;

@private

  RESERVED_IVARS(CEPreferencesLinkerOptionsViewController, 5);
}

@property (nonatomic) IBOutlet NSTableView* frameworksTableView;
@property (nonatomic) IBOutlet NSTableView* sharedLibsTableView;
@property (nonatomic) IBOutlet NSTableView* staticLibsTableView;

- (IBAction)addFramework:(id)sender;
- (IBAction)removeFramework:(id)sender;
- (IBAction)addSharedLib:(id)sender;
- (IBAction)removeSharedLib:(id)sender;
- (IBAction)addStaticLib:(id)sender;
- (IBAction)removeStaticLib:(id)sender;

@end
