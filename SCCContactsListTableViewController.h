//
//  SCCContactsListTableViewController.h
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SCCContactsListContactFetcher.h"
#import "SCCContactTableViewCell.h"
#import "SCCContactDetailViewController.h"

@interface SCCContactsListTableViewController : UITableViewController

//create propertie, 1 array to hold the data
@property (nonatomic, strong) NSArray *simpleContact;

@end
