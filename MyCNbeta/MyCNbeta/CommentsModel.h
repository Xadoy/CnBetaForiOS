//
//  CommentsModel.h
//  MyCNbeta
//
//  Created by Adoy on 6/16/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "NewsModel.h"

@interface CommentsModel : NewsModel

@property (nonatomic,strong) NSString *tid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *date;//time
@property (nonatomic,strong) NSString *supportCounts;
@property (nonatomic,strong) NSString *againstCounts;
@property (nonatomic,strong) NSString *content;
+(NSString*)stringForPublishComment:(NSString*)msg withArticleID:(NSString*)sid;//test



+(void)commentWithID:(NSString*)tid articleID:(NSString*)sid like:(BOOL)isLike Receiver:(id)targetID selector:(SEL)selector notiName:(NSString*)notiName;
+(NSMutableArray*)getCommentModelsWithArray:(NSArray *)arr;
+(void)getCommentListWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector;

@end
