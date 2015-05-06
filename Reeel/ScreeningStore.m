//
//  ScreeningStore.m
//  Reeel
//
//  Created by Paul Dariye on 4/28/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningStore.h"

@interface ScreeningStore()

@property (nonatomic) NSMutableArray *screenings;

@property (nonatomic) NSMutableArray *rsvpedScreenings;

@property (nonatomic) NSDate *randomDate;

@property (nonatomic) long randomNumber;

@property (nonatomic) float randomRating;

@end

@implementation ScreeningStore

@synthesize screenings;
@synthesize rsvpedScreenings;
@synthesize randomDate;
@synthesize randomNumber;
@synthesize randomRating;


+ (instancetype)sharedStore
{
    static ScreeningStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ScreeningStore sharedStore]"  userInfo:nil];
    
    
    return nil;
}


- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        
        screenings = [[NSMutableArray alloc] init];
        rsvpedScreenings = [[NSMutableArray alloc] init];
        
        
        // Date formatter
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDateFormatter *releaseDateFormat = [[NSDateFormatter alloc] init];
        [releaseDateFormat setDateFormat:@"y"];
        [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
        // TODO: date formatter for next year events
        
        NSDate *today = [[NSDate alloc] init];
        
        
        for (int i = 0; i < 10; i++) {
            
//            short randBinary = arc4random() % 2;
            
            randomRating = arc4random_uniform(10);

            randomNumber = arc4random_uniform(60 * 60 * 24 * 60);
//            randomDate = [NSDate dateWithTimeIntervalSinceNow:randomNumber];
            
            
            randomDate = [today dateByAddingTimeInterval:randomNumber];
        

            Screening *screening = [[Screening alloc] initWithScreeningTitle:[NSString stringWithFormat:@"Screening - %d", i] screeningDate:[dateFormat stringFromDate:randomDate] screeningLocation:@"Mercer, NY" screeningTheatre:@"Angelika" screeningSynopsis:@"Some Random text that tells something about the movie or screening...blah blah" screeningReleaseDate:[releaseDateFormat stringFromDate:randomDate] screeningDuration:@"114 min" screeningGenre:@"Drama" screeningDirectorInfo:@"Paul, Collin" screeningStarInfo:@"Paul" screeningRating:randomRating screeningFee:0 discount:0];
            
            //NSLog(@"Meta Dict --> %@", screening.screeningMetaData[@"title"]);
            
            //NSLog(@"Adding item %@", screening);
            
            screening.rsvp = NO;
            
            //NSLog(@"RSVP -->  %i", screening.rsvp);
            
            [screenings addObject:screening];
            
        }
    }
    
    return self;
}

- (NSArray *)allScreenings
{
    return screenings;
}

- (NSArray *)allRSVPedScreenings
{
    return rsvpedScreenings;
}

- (void)rsvpForScreening:(Screening *)screening
{
    if (![screening isRsvped]) {
        screening.rsvp = YES;
        [rsvpedScreenings addObject:screening];
    }
}



- (void)removeScreening:(Screening *)screening
{
    //NSString *key = screening.screeningKey;
    
    [self.screenings removeObjectIdenticalTo:screening];
}

//- (Screening *)createScreening
//{
//    
//}

@end
