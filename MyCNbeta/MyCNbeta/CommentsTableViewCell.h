//
//  CommentsTableViewCell.h
//  MyCNbeta
//
//  Created by Adoy on 6/17/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentsTableViewCell;
@protocol VotingDelegate

-(void)upVoteButtonDidClickFromCell:(CommentsTableViewCell*)cell;
-(void)downVodeButtonDidClickFromCell:(CommentsTableViewCell*)cell;

@end

@interface CommentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;
@property (weak, nonatomic) IBOutlet UILabel *supportCountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *againstCountsLabel;
@property (nonatomic,weak) id<VotingDelegate> votingDelegate;


@property (nonatomic,strong) NSString *tid;


@end



