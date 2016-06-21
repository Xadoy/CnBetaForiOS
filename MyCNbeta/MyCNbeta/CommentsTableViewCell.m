//
//  CommentsTableViewCell.m
//  MyCNbeta
//
//  Created by Adoy on 6/17/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "CommentsTableViewCell.h"

@implementation CommentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}


- (IBAction)didClickVoteButtons:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            [_votingDelegate upVoteButtonDidClickFromCell:self];
            break;
        
        case 1:
            [_votingDelegate downVodeButtonDidClickFromCell:self];
        
        default:
            break;
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
