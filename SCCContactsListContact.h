//
//  SCCContactsListContact.h
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCContactsListContact : NSObject

//decalare simple conatct properties
@property (nonatomic, strong) NSString *employeeName;
@property (nonatomic, assign) NSInteger employeeID;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *detailsURL;
@property (nonatomic, strong) NSString *smallImageURL;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSString *workPhoneNumber;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) NSString *mobilePhoneNumber;

//declare detail contact properties
@property BOOL favorite;
@property (nonatomic, strong) NSString *largeImageURL;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;

@end
