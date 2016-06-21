//
//  CommentsTableViewController.h
//  MyCNbeta
//
//  Created by Adoy on 6/16/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewController : UIViewController


@property (nonatomic,strong) NSString* articleID;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *publishComment;
@property (weak, nonatomic) IBOutlet UIView *inputView;

@end
