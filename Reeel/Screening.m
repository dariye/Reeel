//
//  Screening.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "Screening.h"

@implementation Screening

@synthesize screeningKey;
@synthesize screeningTitle;
@synthesize screeningDate;
@synthesize screeningLocation;
@synthesize screeningTheatre;
@synthesize screeningSynopsis;
@synthesize screeningReleaseDate;
@synthesize screeningDuration;
@synthesize screeningGenre;
@synthesize screeningDirectorInfo;
@synthesize screeningStarInfo;
@synthesize dateCreated;
@synthesize screeningFee;
@synthesize screeningRating;
@synthesize discount;
@synthesize free;
@synthesize discounted;
@synthesize rsvp;

/*************************************************
 *           Class Method Implementations        *
 *************************************************/

/*************************************************
 *         Implementation of Initializers        *
 *************************************************/

- (instancetype)initWithScreeningTitle:(NSString *)title screeningDate:(NSString *)date screeningLocation:(NSString *)location screeningTheatre:(NSString *)theatre screeningSynopsis:(NSString *)synopsis screeningReleaseDate:(NSString *)release screeningDuration:(NSString *)duration screeningGenre:(NSString *)genre screeningDirectorInfo:(NSString *)directorInfo screeningStarInfo:(NSString *)starInfo screeningRating:(float)rating screeningFee:(float)fee discount:(float)discountValue
{
    self = [super init];
    
    if (self) {
        screeningDate = date;
        screeningLocation = location;
        screeningTheatre = theatre;
        screeningFee = fee;
        discount = discountValue;
        screeningSynopsis = synopsis;
        screeningReleaseDate = release;
        screeningDuration = duration;
        screeningGenre = genre;
        screeningDirectorInfo = directorInfo;
        screeningStarInfo = starInfo;
        screeningRating = rating;
        if (screeningFee && discount) {
            discounted = YES;
            free = NO;
        } else if (fee) {
            free = NO;
            discounted = NO;
        } else {
            free = YES;
            discounted = NO;
        }

        rsvp = NO;
        
        // Date formatter
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        
        dateCreated = [dateFormat stringFromDate:[[NSDate alloc] init]];
        
        // Assign unique Key
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        screeningKey = key;
    }
    
    return self;
}

- (instancetype)initWithScreeningTitle:(NSString *)title
{
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    return [self initWithScreeningTitle:@"" screeningDate:@"" screeningLocation:@"" screeningTheatre:@"" screeningSynopsis:@"" screeningReleaseDate:@"" screeningDuration:@"" screeningGenre:@"" screeningDirectorInfo:@"" screeningStarInfo:@"" screeningRating:0.0 screeningFee:0.0 discount:0.0];
}

- (instancetype)init
{
    return [self initWithScreeningTitle:@"ScreeningTitle"];
}


/*************************************************
 *         Implementation of Acessors            *
 *************************************************/

//
// - (void)setScreeningTitle:(NSString *)str
//{
//    _screeningTitle = str;
//}
//
//- (NSString *)screeningTitle
//{
//    return _screeningTitle;
//}
//
//- (void)setScreeningDate:(NSString *)str
//{
//    self.screeningDate = str;
//}


@end
