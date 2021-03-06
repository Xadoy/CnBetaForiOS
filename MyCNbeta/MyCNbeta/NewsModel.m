//
//  NewsModel.m
//  MyCNbeta
//
//  Created by Adoy on 6/6/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "NewsModel.h"
#import "AFNetworking/UIActivityIndicatorView+AFNetworking.h"
@implementation NewsModel


+(NSString*)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            
            
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
    
}

+(int)currentTimeStamp{
    
    return  [[NSDate date]timeIntervalSince1970];
}

+(void)getArticleAfterID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector{
    NSString *url = [self stringForNewsContentAfterArticleID:sid];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:@"moreNewsGetSuccess" object:nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:@"moreNewsGetSuccess" object:dic];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];
}

+(void)getArticleWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector{
    NSString *url = [self stringForNewsContentWithArticleID:sid];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:@"htmlGetSuccess" object:nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    AFHTTPResponseSerializer *temp = [AFHTTPResponseSerializer serializer];
//    temp.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html" , nil];
//    manager.requestSerializer = temp;
    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:@"htmlGetSuccess" object:dic];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];
}
+(void)getArticleWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector notificationName:(NSString *)notiName{
    NSString *url = [self stringForNewsContentWithArticleID:sid];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:notiName object:nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    AFHTTPResponseSerializer *temp = [AFHTTPResponseSerializer serializer];
    //    temp.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html" , nil];
    //    manager.requestSerializer = temp;
    
    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:notiName object:dic];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];
}

+(void)getNewsListWithReceiver:(id)targetID selector:(SEL)selector{
    
    NSString *url = [self stringForNewsList];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:@"jsonGetSuccess" object:nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:@"jsonGetSuccess" object:dic];
             
    }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];

}
+(void)getTopTenNewsListWithReceiver:(id)targetID selector:(SEL)selector{
    
    NSString *url = [self stringForTopTenNewsList];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:@"topTenJsonGetSuccess" object:nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:@"topTenJsonGetSuccess" object:dic];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];
    
}
+(NSString*)stringForNewsContentAfterArticleID:(NSString*)sid{
    NSString *result = @"http://api.cnbeta.com/capi?";
    //                                           app_key=10000&end_sid=$sid&format=json&method=Article.Lists&timestamp=&topicid=null&v=1.0&mpuffgvbvbttn3Rc
    NSString *url = [NSString stringWithFormat:@"app_key=10000&end_sid=%@&format=json&method=Article.Lists&timestamp=%d&topicid=null&v=1.0&",sid,[self currentTimeStamp]];

    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    NSLog(result);
    return result;
}
+(NSString*)stringForNewsContentWithArticleID:(NSString*)sid{
    NSString *result = @"http://api.cnbeta.com/capi?";
 //                            app_key=10002&articleId=508901&format=json&method=phone.NewsContent2&timestamp=1465372206&v=1.0&sign=c49e1ca47ecb312bc8cce53c0537550b
    NSString *url = [NSString stringWithFormat:@"app_key=10000&format=json&method=Article.NewsContent&sid=%@&timestamp=%d&v=1.0&",sid,[self currentTimeStamp]];
//    NSString *url = [NSString stringWithFormat:@"app_key=10000&articleId=%@&format=json&method=phone.NewsContent2&timestamp=%d&v=1.0&",sid,[self currentTimeStamp]];
    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    NSLog(result);
    return result;
}
+(NSString*)stringForCommentsListForArticleID:(NSString*)sid{
    NSString *result = @"http://api.cnbeta.com/capi?";
    //                                           app_key=10000&format=json&method=Article.Comment&page=&sid=&timestamp=&v=1.0&sign=
    NSString *url = [NSString stringWithFormat:@"app_key=10000&article=%@&format=json&method=phone.Comment&timestamp=%d&v=1.0&",sid,[self currentTimeStamp]];
    
    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    NSLog(result);
    return result;
}

+(NSString*)stringForTopTenNewsList{
   
    NSString *result = @"http://api.cnbeta.com/capi?";
    //app_key=10000&format=json&method=Article.Top10&timestamp=v=1.0&sign=
    NSString *url = [NSString stringWithFormat:@"app_key=10000&format=json&method=Article.Top10&timestamp=%dv=1.0&",[self currentTimeStamp]];
    NSString *temp = @"mpuffgvbvbttn3Rc";
    NSLog([url stringByAppendingString:temp]);
    temp = [self md5:[url stringByAppendingString:temp]];
    //[self md5:url];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    
    
    
    
    
    
    
    return result;
}
+(NSString*)stringForNewsList{
    NSString *result = @"http://api.cnbeta.com/capi?";
                    //app_key=10000&format=json&method=Article.Top10&timestamp=v=1.0&sign=
    NSString *url = @"app_key=10000&format=json&method=Article.Lists&timestamp=";
    url = [url stringByAppendingString:[NSString stringWithFormat:@"%d&v=1.0&",[self currentTimeStamp]]];
    NSString *temp = @"mpuffgvbvbttn3Rc";
    NSLog([url stringByAppendingString:temp]);
    temp = [self md5:[url stringByAppendingString:temp]];
    //[self md5:url];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    
    
    
    
    
    
    
    return result;
}

+(NSMutableArray*)getNewsModelsWithArray:(NSArray *)arr{
    NSMutableArray *modelsArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(int i=0;i<arr.count;i++){
        NSDictionary *info = arr[i];
        NewsModel *aNewsModel = [[NewsModel alloc]init];
        aNewsModel.title = [info objectForKey:@"title"];
        aNewsModel.articleID = [info objectForKey:@"sid"];
        aNewsModel.summary = [info objectForKey:@"summary"];
        aNewsModel.pubTime = [info objectForKey:@"pubtime"];
        aNewsModel.viewCounts = [info objectForKey:@"counter"];
        aNewsModel.commentCounts = [info objectForKey:@"comments"];

        aNewsModel.thumbImgUrlString = [info objectForKey:@"thumb"];
        
        [modelsArr addObject:aNewsModel];
    }
    
    
    return modelsArr;
}

+(void)getCommentListWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector notiName:(NSString*)notiName{
    NSString *url = [self stringForCommentsListForArticleID:sid];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:notiName object:nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    AFHTTPResponseSerializer *temp = [AFHTTPResponseSerializer serializer];
    //    temp.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html" , nil];
    //    manager.requestSerializer = temp;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:notiName object:dic];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];
}



//+(NSString*)omg{
//    char chain[]="qwertyuiopasdfghjklzxcvbnm";
//    mpuffgvbvbttn3Rc
//    NSString *ans;
//    NSString *key = [NSstring stringWithFormat:@"app_key=10002&format=json&limit=20&method=phone.Newslist&timestamp=1465264411&v=1.0&%@",ans];
//}

@end
