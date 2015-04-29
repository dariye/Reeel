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

@property (nonatomic) NSDate *randomDate;

@property (nonatomic) long randomNumber;

@end

@implementation ScreeningStore

@synthesize screenings;
@synthesize randomDate;
@synthesize randomNumber;

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
        
        // Date formatter
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        
        
        for (int i = 0; i < 10; i++) {
            
            randomNumber = arc4random_uniform(60 * 60 * 24 * 60);
            randomDate = [NSDate dateWithTimeIntervalSinceNow:randomNumber];
            
            Screening *screening = [[Screening alloc] initWithScreeningTitle:[NSString stringWithFormat:@"Screening - %d", i] screeningDate:@"April 28th, 2015" screeningLocation:@"Mercer, NY" screeningTheatre:@"Angelika" screeningDescription:@"Some Random text that tells something about the movie or screening...blah blah" screeningFee:i discount:0];
            
            NSLog(@"Adding item %@", screening);
            [screenings addObject:screening];
            
            
        }
        NSLog(@"Count -- > %i", [screenings count]);
    }
    
    return self;
}

- (NSArray *)allScreenings
{
    return screenings;
}
- (void)removeScreening:(Screening *)screening
{
    NSString *key = screening.screeningKey;
    
    [self.screenings removeObjectIdenticalTo:screening];
}

//- (Screening *)createScreening
//{
//    
//}

@end
