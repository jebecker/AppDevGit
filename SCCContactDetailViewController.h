//
//  SCCContactDetailViewController.h
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCCContactsListContactFetcher.h"


@interface SCCContactDetailViewController : UIViewController

//declare iboutlets for the labels in the detail view controller
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *favoriteLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayCompanyLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayWorkNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayHomeNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayMobileNumberLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayAddressLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayBirthdayLabel;
@property (nonatomic, strong) IBOutlet UILabel *displayEmailLabel;

@property (nonatomic, strong) NSArray *detailedContact;

//declare properties for the detailed contact info
@property BOOL favorite;
@property (nonatomic, strong) SCCContactsListContact *contact;


@end
