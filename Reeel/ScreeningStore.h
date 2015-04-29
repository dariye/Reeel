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

+ (instancetype)sharedStore;

//- (Screening *)createScreening;
- (void)removeScreening:(Screening *)screening;

@end
