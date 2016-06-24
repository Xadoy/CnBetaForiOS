//
//  NewsModel.h
//  MyCNbeta
//
//  Created by Adoy on 6/6/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <AFNetworking/AFNetworking.h>
@interface NewsModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *articleID;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *pubTime;
@property (nonatomic,strong) NSString *viewCounts;
@property (nonatomic,strong) NSString *commentCounts;
@property (nonatomic,strong) NSString *thumbImgUrlString;

//-(NewsModel)getNews
+(int)currentTimeStamp;
+(NSString*)md5:(NSString *)str;
+(NSMutableArray*)getNewsModelsWithArray:(NSArray*)arr;
+(NSString*)stringForNewsList;
+(void)getNewsListWithReceiver:(id)targetID selector:(SEL)selector;//20
+(void)getArticleWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector;
+(void)getArticleAfterID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector;
+(void)getTopTenNewsListWithReceiver:(id)targetID selector:(SEL)selector;
+(void)getArticleWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector notificationName:(NSString*)notiName;//for override
+(NSString*)stringForCommentsListForArticleID:(NSString*)sid;
+(void)getCommentListWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector notiName:(NSString*)notiName;
@end
