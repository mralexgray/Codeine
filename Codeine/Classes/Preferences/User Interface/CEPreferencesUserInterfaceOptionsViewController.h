
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesUserInterfaceOptionsViewController : CEViewController {
@protected

  NSMatrix* _fullScreenStyleMatrix;

@private

  RESERVED_IVARS(CEPreferencesUserInterfaceOptionsViewController, 5);
}

@property (nonatomic) IBOutlet NSMatrix* fullScreenStyleMatrix;

- (IBAction)setFullScreenStyle:(id)sender;

@end
