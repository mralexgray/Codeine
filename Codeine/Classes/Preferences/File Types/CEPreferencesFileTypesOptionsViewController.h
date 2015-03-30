
/* $Id$ */

#import "CEViewController.h"

FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerColumnIconIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerColumnExtensionIdentifier;
FOUNDATION_EXPORT NSString* const CEPreferencesCompilerOptionsViewControllerColumnTypeIdentifier;

@class CEMutableOrderedDictionary;
@class CEPreferencesFileTypesAddNewViewController;

@interface CEPreferencesFileTypesOptionsViewController : CEViewController {
@protected

  NSTableView* _tableView;
  CEMutableOrderedDictionary* _fileTypes;
  CEPreferencesFileTypesAddNewViewController* _addNewController;

@private

  RESERVED_IVARS(CEPreferencesFileTypesOptionsViewController, 5);
}

@property (nonatomic) IBOutlet NSTableView* tableView;

- (IBAction)addFileType:(id)sender;
- (IBAction)removeFileType:(id)sender;

@end
