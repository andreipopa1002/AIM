//
//  RTBaseViewController.h
//  RecruiterTest
//
//  Created by Popa Andrei on 31/05/2015.
//  Copyright (c) 2015 Popa Andrei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This class will act as a base class for all UIViewController
 */
@interface RTBaseViewController : UIViewController

/**
 * This method will present a semi-transparent view on the main view of the controller to
 * suggest to the user that some activity is in progress
 */
- (void)showLoadingIndicator;

/**
 * This method will be called when the work is done and will cause the overlay to be dismissed
 */
- (void)hideLoadingIndicator;

@end
