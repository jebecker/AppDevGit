//
//  SCCContactsListContactFetcher.h
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCCContactsListContact.h"

@interface SCCContactsListContactFetcher : NSObject

//declare 2 functions to fetch the simple contact info and the detailed contact info
+(void)fetchSimpleContact;
+(void)fetchDetailsForContact: (SCCContactsListContact *)contact;

@end
