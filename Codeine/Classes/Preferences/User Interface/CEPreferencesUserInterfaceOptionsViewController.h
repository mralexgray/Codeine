
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesUserInterfaceOptionsViewController : CEViewController {
@protected

  NSMatrix* __weak _fullScreenStyleMatrix;

@private

  RESERVED_IVARS(CEPreferencesUserInterfaceOptionsViewController, 5);
}

@property (weak, nonatomic) IBOutlet NSMatrix* fullScreenStyleMatrix;

- (IBAction)setFullScreenStyle:(id)sender;

@end
