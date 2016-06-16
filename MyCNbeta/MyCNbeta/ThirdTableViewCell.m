//
//  ThirdTableViewCell.m
//  MyCNbeta
//
//  Created by Adoy on 6/8/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "ThirdTableViewCell.h"
#define SCREENWIDTH 320.0
@implementation ThirdTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//    UIView *temp = self.bgView;
//   
//    if (selected||self.highlighted) {
//        temp.backgroundColor = [UIColor purpleColor];
//    }
//    else
//        temp.backgroundColor = [UIColor whiteColor];
//
//}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    [super setHighlighted:highlighted animated:animated];
//    UIView *temp = self.bgView;
//
//    if (highlighted||self.selected) {
//        temp.backgroundColor = [UIColor purpleColor];
//    }
//    else
//        temp.backgroundColor = [UIColor whiteColor];
//    
//}
-(void) pleaseAddBarViewForRow:(NSInteger)row{
    CGFloat width = SCREENWIDTH-(row)/10.0*280.0;
//    CGFloat x     = (SCREENWIDTH - width)/2.0;
    CGFloat colorCode= (CGFloat)(0.1*row);
    if(!_barView){
        _barView = [[UIView alloc]init];
        _barView.backgroundColor = [UIColor colorWithRed:1.0 green:colorCode blue:0 alpha:1];
        [self addSubview:_barView];
    }
    _barView.frame = CGRectMake(0, 0,width , 6);
    _barView.backgroundColor = [UIColor colorWithRed:1.0 green:colorCode blue:0 alpha:1];
}


@end
