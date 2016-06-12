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
@property (nonatomic,strong) UIImage  *thumbImg;
@property (nonatomic,strong) NSString *summary;


//-(NewsModel)getNews
+(int)currentTimeStamp;
+(NSString*)md5:(NSString *)str;
+(NSMutableArray*)getNewsModelsWithArray:(NSArray*)arr;
+(NSString*)stringForNewsList;
+(void)getNewsListWithReceiver:(id)targetID selector:(SEL)selector;//20
+(void)getArticleWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector;
+(void)getArticleAfterID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector;
@end
