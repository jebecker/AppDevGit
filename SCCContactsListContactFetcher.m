//
//  SCCContactsListContactFetcher.m
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import "SCCContactsListContactFetcher.h"

@implementation SCCContactsListContactFetcher

+(void)fetchSimpleContact
{
    //create a string abd url for the JSON data url to download
    NSString *urlString = @"https://solstice.applauncher.com/external/contacts.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    //set up the session
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSLog(@"HEY WE HAVE DATA");
            [SCCContactsListContactFetcher processSimpleContactInfoFromData:data];
        }
        else
        {
            NSLog(@"SOMETHING UNEXPECTED HAPPENED");
        }
    }]resume];

}

//method to process the initial data from the json url
+(void)processSimpleContactInfoFromData: (NSData *)data
{
    //create an array to store the data
    NSMutableArray *simpleContact = [[NSMutableArray alloc]init];

    //create error
    NSError *error;
    
    //get the root array for the JSON
    NSArray *simpleContactsArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    for(NSDictionary *dictionary in simpleContactsArray)
    {
        SCCContactsListContact *contact = [[SCCContactsListContact alloc] init];
        contact.employeeName = dictionary[@"name"];
        contact.employeeID = [dictionary[@"employeeId"]integerValue];
        contact.company = dictionary[@"company"];
        contact.detailsURL = dictionary[@"detailsURL"];
        contact.smallImageURL = dictionary[@"smallImageURL"];
        contact.birthday = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"birthdate"] integerValue]];
        NSDictionary *phone = dictionary[@"phone"];
        contact.workPhoneNumber = phone[@"work"];
        contact.homePhoneNumber = phone[@"home"];
        contact.mobilePhoneNumber = phone[@"mobile"];
        [simpleContact addObject:contact];

    }
    //set up nsnotification center
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SCCContactsListFinishedProcessing" object:nil userInfo:@{@"simpleContact" : simpleContact}];
    
}

//method to process the detailed data from the details json url
+(void)fetchDetailsForContact:(SCCContactsListContact *)contact
{
    //create a string abd url for the JSON data url to download
    NSString *urlString = contact.detailsURL;
    NSURL *url = [NSURL URLWithString:urlString];
    
    //set up the session
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSLog(@"HEY WE HAVE THE DETAILED DATA");
            [SCCContactsListContactFetcher processDetailedContactInfoFromData:data forContact:contact];
        }
        else
        {
            NSLog(@"SOMETHING UNEXPECTED HAPPENED");
        }
    }]resume];
}

+(void)processDetailedContactInfoFromData: (NSData *)data forContact:(SCCContactsListContact *)contact
{
    //create error
    NSError *error;
    
    //get the root array for the JSON
    NSDictionary *detailedContactDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    contact.favorite = [detailedContactDictionary[@"favorite"] boolValue];
    contact.largeImageURL = detailedContactDictionary[@"largeImageURL"];
    contact.email = detailedContactDictionary[@"email"];
    NSDictionary *address = detailedContactDictionary[@"address"];
    contact.street = address[@"street"];
    contact.city = address[@"city"];
    contact.state = address[@"state"];
    
    //set up nsnotification center
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SCCDetailedContactsListFinishedProcessing" object:nil userInfo:@{@"detailedContact" : contact}];
}

@end
