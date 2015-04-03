//
//  SCCContactDetailViewController.m
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import "SDWebImageHeaders.h"
#import "SCCContactDetailViewController.h"

@implementation SCCContactDetailViewController

#pragma mark - Notification handling

-(void)respondToProcessingComplete:(NSNotification *)notification
{
    NSLog(@"PROCESSING COMPLETE");
    NSDictionary *userInfo = notification.userInfo;
    self.contact = userInfo[@"detailedContact"];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self reloadData];
    }];
    
}

- (void)viewDidLoad
{
    //listen for the specific notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToProcessingComplete:) name:@"SCCDetailedContactsListFinishedProcessing" object: nil];

    [SCCContactsListContactFetcher fetchDetailsForContact: self.contact];
    [self reloadData];

    
}

-(void)reloadData
{
    
    //create date formatter
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    //set the labels text to the correct info
    self.displayNameLabel.text = self.contact.employeeName;
    self.displayCompanyLabel.text = self.contact.company;
    self.displayWorkNumberLabel.text = self.contact.workPhoneNumber;
    self.displayHomeNumberLabel.text = self.contact.homePhoneNumber;
    self.displayMobileNumberLabel.text = self.contact.mobilePhoneNumber;
    self.displayAddressLabel.text = [NSString stringWithFormat:@"%@\n%@, %@", self.contact.street, self.contact.city, self.contact.state];
    self.displayBirthdayLabel.text = [dateFormatter stringFromDate:self.contact.birthday];
    self.displayEmailLabel.text = self.contact.email;
    
    //set image view using SDWebimage setImageWithURL
    [self.imageView setImageWithURL:[NSURL URLWithString:self.contact.smallImageURL] placeholderImage:[UIImage imageNamed:@"transparent"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        self.imageView.image = image;
        [self.imageView setNeedsDisplay];
        [self.imageView layoutIfNeeded];
    }];
   
    
    //if contact is a favorite, unhide the star
    if(self.contact.favorite == true)
    {
        self.favoriteLabel.hidden = NO;
    }
    
}



@end
