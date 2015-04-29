//
//  Screening.h
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Screening : NSObject

// screening view attributes
@property (nonatomic, strong) NSDate *screeningDate;
@property (nonatomic, strong) NSString *screeningLocation;
@property (nonatomic, strong) NSString *screeningDirectors;
@property (nonatomic) float *screeningRating;
@property (nonatomic, strong) NSString *screeningSynopsis;

// detail view only attributes
@property (nonatomic, strong) NSString *screeningWriters;
@property (nonatomic, strong) NSString *screeningStars;
@property (nonatomic, strong) NSString *screeningMetadata;
@property (nonatomic) BOOL rsvpStatus;

// other possible attributes
//@property (nonatomic, strong) NSString *screeningTitle;
//@property (nonatomic) float screeningFee;
//@property (nonatomic) BOOL free;
//@property (nonatomic) BOOL discount;
//@property (nonatomic, strong) NSDate *dateCreated;


/* ===================================
            Instance Methods
 =================================== */



/* ===================================
    Accessors(Getters & Setters)
 =================================== */

//- (void)setScreeningTitle:(NSString *)screeningTitle;
//- (NSString *)screeningTitle;

- (void)setScreeningDate:(NSDate *)screeningDate;
- (NSDate *)screeningDate;

- (void)setScreeningLocation:(NSString *)screeningLocation;
- (NSString *)screeningLocation;








@end
