//
//  SCCContactsListTableViewController.m
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//


#import "SCCContactsListTableViewController.h"
#import "SDWebImageHeaders.h"

@implementation SCCContactsListTableViewController

//create a static string for the cell identifier
static NSString *cellIdentifier = @"Cell";


#pragma mark - Notification handling

-(void)respondToProcessingComplete:(NSNotification *)notification
{
    NSLog(@"PROCESSING COMPLETE");
    NSDictionary *userInfo = notification.userInfo;
    self.simpleContact = userInfo[@"simpleContact"];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
    }];
    
}

- (void)viewDidLoad
{
    //set up notfication senter and call the fetchSimpleContact method to 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToProcessingComplete:) name:@"SCCContactsListFinishedProcessing" object: nil];
    [SCCContactsListContactFetcher fetchSimpleContact];
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    SCCContactsListContact *contact = self.simpleContact[indexPath.row];
    
    cell.contactLabel.text = contact.employeeName;
    
    //only put the work number on the initial contact list per the wirefram, but shouldn't it display all 3 numbers?
    cell.phoneNumberLabel.text = contact.workPhoneNumber;
    
    //set image view using SDWebimage setImageWithURL
    [cell.contactImageView setImageWithURL:[NSURL URLWithString:contact.smallImageURL] placeholderImage:[UIImage imageNamed:@"transparent"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        cell.contactImageView.image = image;
        cell.contactImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.contactImageView.clipsToBounds = YES;
        [cell.contactImageView setNeedsDisplay];
        [cell.contactImageView layoutIfNeeded];
    }];
    
    return cell;
}

//prepare for seque method to send the detailed information to the detail view controller to populate data
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"detailContactSeque"]){
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        //get selected contact
        SCCContactsListContact *contact = self.simpleContact[selectedIndexPath.row];
        
        //set destination view and send contact info
        SCCContactDetailViewController *destination =[segue destinationViewController];
        destination.contact = contact;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.simpleContact.count;
}


@end
