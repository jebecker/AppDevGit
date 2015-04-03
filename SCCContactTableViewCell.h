//
//  SCCContactTableViewCell.h
//  Solstice_Mobile_Code_Challenge
//
//  Created by Jayme Becker on 9/24/14.
//  Copyright (c) 2014 Jayme Becker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SCCContactTableViewCell : UITableViewCell

//create 3 IBOutlet so I can access the lables and image view
@property (nonatomic, strong) IBOutlet UIImageView *contactImageView;
@property (nonatomic, strong) IBOutlet UILabel *contactLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneNumberLabel;

@end
