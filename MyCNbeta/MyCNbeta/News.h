//
//  News.h
//  MyCNbeta
//
//  Created by Adoy on 6/23/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsManagedObject+CoreDataProperties.h"
@interface News : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *articleID;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *pubTime;
@property (nonatomic,strong) NSString *viewCounts;
@property (nonatomic,strong) NSString *commentCounts;
@property (nonatomic,strong) NSString *thumbImgUrlString;
@property (nonatomic,assign) NSInteger hotCommentRanking;
@property (nonatomic,strong) NSString *htmlString;
@property (nonatomic,assign) BOOL *isViewed;

-(News*)initWithManagedObject:(NewsManagedObject*)obj;

@end
