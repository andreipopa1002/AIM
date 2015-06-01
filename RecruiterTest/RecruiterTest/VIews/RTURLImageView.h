//
//  RTURLImageView.h
//  RecruiterTest
//
//  Created by Andrei Popa on 20/03/2014.
//  Copyright (c) 2014 Andrei Popa. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  This class will display an image from an URL, by donwloading it asynchronously
 */
@interface RTURLImageView : UIView
@property (nonatomic, strong, readwrite) NSURL *imageURL;

@end
