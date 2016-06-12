//
//  ThirdTableViewCell.h
//  MyCNbeta
//
//  Created by Adoy on 6/8/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;


@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
