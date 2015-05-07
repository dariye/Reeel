//
//  ScreeningStore.h
//  Reeel
//
//  Created by Paul Dariye on 4/28/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Screening.h"

@class Screening;

@interface ScreeningStore : NSObject

@property (nonatomic, readonly) NSArray *allScreenings;

@property (nonatomic, readonly) NSArray *allRSVPedScreenings;

+ (instancetype)sharedStore;

- (void)rsvpForScreening:(Screening *)screening;
- (void)optOut:(Screening *)screening;

@end
