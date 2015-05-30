//
//  RTURLImageView.m
//  RecruiterTest
//
//  Created by Andrei Popa on 20/03/2014.
//  Copyright (c) 2014 Andrei Popa. All rights reserved.
//

#import "RTURLImageView.h"

@protocol RTURLDummyObjectDelegate <NSObject>

- (void)dummyDelegateDidReceivedData:(NSData *)data;
- (void)dummyDelegateDidReceivedFailedToReceiveData:(NSError *)error;

@end

@interface RTURLDummyObject : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong, readwrite) NSMutableData *imageData;
@property (nonatomic, weak, readwrite) id<RTURLDummyObjectDelegate> delegate;

@end

@implementation RTURLDummyObject

#pragma mark - NSURLConnection data delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (!self.imageData) {
        self.imageData = [NSMutableData new];
    }
    [self.imageData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dummyDelegateDidReceivedFailedToReceiveData:)]) {
        [self.delegate dummyDelegateDidReceivedFailedToReceiveData:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dummyDelegateDidReceivedData:)]) {
        [self.delegate dummyDelegateDidReceivedData:self.imageData];
    }
}


@end

@interface RTURLImageView() <RTURLDummyObjectDelegate>

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong, readwrite) NSURLConnection *urlConnection;

@property (nonatomic, weak, readwrite) RTURLDummyObject *dummyObject;

- (void)setupConstraints;
- (void)prepareSetupForNewImageDownload;
- (void)prepareSetupForRevealingImage:(UIImage *)image;
- (void)prepareSetupForError:(NSError *)error;

@end

@implementation RTURLImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)dealloc {
    [self.urlConnection cancel];
}

#pragma mark - Custom setters & getters
- (void)setImageURL:(NSURL *)imageURL {
    if (imageURL != _imageURL) {
        _imageURL = imageURL;
        if (self.urlConnection) {
            [self.urlConnection cancel];
            [self prepareSetupForRevealingImage:nil];
        }
        if (imageURL) {
            RTURLDummyObject *dummyObject = [RTURLDummyObject new];
            dummyObject.delegate = self;
            self.urlConnection = [[NSURLConnection alloc] initWithRequest:[[NSURLRequest alloc] initWithURL:imageURL]
                                                                 delegate:dummyObject
                                                         startImmediately:NO];
            self.dummyObject = dummyObject;
            [self prepareSetupForNewImageDownload];
            [self.urlConnection start];
        }
    }
}

#pragma mak - Internal methods
- (void)setupViews {
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    [self addSubview:self.activityIndicator];
    self.backgroundColor = [UIColor grayColor];
    [self setupConstraints];
}

- (void)setupConstraints {
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(_imageView,_activityIndicator);
    // make sure the imageView covers the entire superview
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    // center the activity indicator
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                      attribute:NSLayoutAttributeCenterX
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeCenterX
                                                     multiplier:1.f constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f constant:0.f]];
}

- (void)prepareSetupForNewImageDownload {
    self.imageView.hidden = YES;
    self.imageView.image = nil;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)prepareSetupForRevealingImage:(UIImage *)image {
    self.imageView.alpha = 0.0f;
    self.imageView.hidden = NO;
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.imageView.image = image;
    if (self.imageView.image) {
        [UIView animateWithDuration:1.0f animations:^{
            self.imageView.alpha = 1.0f;
        }];
    } else {
        [self prepareSetupForError:[NSError errorWithDomain:@"No image data" code:100 userInfo:nil]];
    }
}

- (void)prepareSetupForError:(NSError *)error {
    self.activityIndicator.hidden = YES;
    self.urlConnection = nil;
    NSLog(@"ERROR: %@",error);
}

#pragma mark - RTURLDummyObjectDelegate methods
- (void)dummyDelegateDidReceivedData:(NSData *)data {
    [self prepareSetupForRevealingImage:[UIImage imageWithData:data]];
}

- (void)dummyDelegateDidReceivedFailedToReceiveData:(NSError *)error {
    [self prepareSetupForError:error];
}

@end
