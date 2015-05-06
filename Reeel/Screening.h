//
//  Screening.h
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Screening : NSObject

@property (nonatomic, copy) NSString *screeningKey;
@property (nonatomic, copy) NSString *screeningTitle;
@property (nonatomic, copy) NSString *screeningDate;
@property (nonatomic, copy) NSString *screeningLocation;
@property (nonatomic, copy) NSString *screeningTheatre;
@property (nonatomic, copy) NSString *screeningSynopsis;
@property (nonatomic, copy) NSString *screeningReleaseDate;
@property (nonatomic, copy) NSString *screeningDuration;
@property (nonatomic, copy) NSString *screeningGenre;
@property (nonatomic, copy) NSString *screeningDirectorInfo;
@property (nonatomic, copy) NSString *screeningStarInfo;
@property (nonatomic) float screeningRating;
@property (nonatomic, readonly, strong) NSString *dateCreated;
@property (nonatomic) float screeningFee;
@property (nonatomic) float discount;


@property (nonatomic, getter=isFree) BOOL free;
@property (nonatomic, getter=isDiscounted) BOOL discounted;
@property (nonatomic, getter=isRsvped) BOOL rsvp;

/**********************************
 *           Class Methods        *
 **********************************/

//+ (instancetype)randomItem;

/*********************************
 *           Initializers        *
 *********************************/
- (instancetype)initWithScreeningTitle:(NSString *)title screeningDate:(NSString *)date screeningLocation:(NSString *)location screeningTheatre:(NSString *)theatre screeningSynopsis:(NSString *)synopsis screeningReleaseDate:(NSString *)release screeningDuration:(NSString *)duration screeningGenre:(NSString *)genre screeningDirectorInfo:(NSString *)directorInfo screeningStarInfo:(NSString *)starInfo screeningRating:(float)rating screeningFee:(float)fee discount:(float)discountValue;

- (instancetype)initWithScreeningTitle:(NSString *)title;


/*******************************************
 *      Accessors(Getters & Setters)       *
 *******************************************/


//- (void)setScreeningTitle:(NSString *)str;
//- (NSString *)screeningTitle;
//
//- (void)setScreeningDate:(NSString *)str;
//- (NSString *)screeningDate;
//
//- (void)setScreeningLocation:(NSString *)str;
//- (NSString *)screeningLocation;
//
//- (void)setScreeningTheatre:(NSString *)str;
//- (NSString *)screeningTheatre;
//
//- (void)setScreeningFee:(float)value;
//- (float)screeningFee;
//
//- (void)setDiscount:(float)value;
//- (float)discount;
//
//- (NSString *)dateCreated;


@end
