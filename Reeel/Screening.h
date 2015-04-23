//
//  Screening.h
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Screening : NSObject

@property (nonatomic, strong) NSString *screeningTitle;
@property (nonatomic, strong) NSDate *screeningDate;
@property (nonatomic, strong) NSString *screeningLocation;
@property (nonatomic, strong) NSString *screeningTheatre;
@property (nonatomic) float screeningFee;

@property (nonatomic) BOOL free;
@property (nonatomic) BOOL discount;

@property (nonatomic, strong) NSDate *dateCreated;

/* ===================================
            Instance Methods
 =================================== */



/* ===================================
    Accessors(Getters & Setters)
 =================================== */

- (void)setScreeningTitle:(NSString *)screeningTitle;
- (NSString *)screeningTitle;

- (void)setScreeningDate:(NSDate *)screeningDate;
- (NSDate *)screeningDate;

- (void)setScreeningLocation:(NSString *)screeningLocation;
- (NSString *)screeningLocation;

- (void)setScreeningTheatre:(NSString *)screeningTheatre;
- (NSString *)screeningTheatre;







@end
