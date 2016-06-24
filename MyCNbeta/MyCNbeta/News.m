//
//  News.m
//  MyCNbeta
//
//  Created by Adoy on 6/23/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "News.h"

@implementation News

-(News *)initWithManagedObject:(NewsManagedObject *)obj{
    self = [super init];
    self.articleID = obj.articleID;
    self.commentCounts = obj.commentCounts;
    self.hotCommentRanking = [obj.hotCommentRanking integerValue];
    self.htmlString = obj.htmlString;
    self.isViewed = [obj.isViewed boolValue];
    self.pubTime = obj.pubtime;
    self.summary = obj.summary;
    self.thumbImgUrlString = obj.thumbImgPath;
    self.title = obj.title;
    self.viewCounts = obj.viewCounts;
    
    return self;
}


@end
