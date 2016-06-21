//
//  ThirdTableViewCell.h
//  MyCNbeta
//
//  Created by Adoy on 6/8/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"
@interface ThirdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountsLabel;
@property (strong,nonatomic) TriangleView    *barView;

@property (weak, nonatomic) IBOutlet UILabel *commentCountsLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;


-(void)pleaseAddBarViewForRow:(NSInteger)row;
@end
