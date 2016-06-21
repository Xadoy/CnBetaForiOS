//
//  CommentsModel.m
//  MyCNbeta
//
//  Created by Adoy on 6/16/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "CommentsModel.h"

@implementation CommentsModel

+(void)getCommentListWithID:(NSString*)sid Receiver:(id)targetID selector:(SEL)selector{
    [super getCommentListWithID:sid Receiver:targetID selector:selector notiName:@"commentListGetSuccess"];
}
+(NSString*)stringForPublishComment:(NSString*)msg withArticleID:(NSString*)sid{
    NSString *result = @"http://api.cnbeta.com/capi?";
//    msg = [msg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *data1 = @"烂苹果";
    NSString *data1test = [msg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSLog(@"%@",data1test);

    NSString *url = [NSString stringWithFormat:@"app_key=10000&content=%@&format=json&method=phone.DoCmt&sid=%@&timestamp=%d&v=1.0&",msg,sid,[self currentTimeStamp]];
    
    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    NSLog(@"%@",result);
    return result;
}
+(NSMutableArray*)getCommentModelsWithArray:(NSArray *)arr{
    NSMutableArray *modelsArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(int i=0;i<arr.count;i++){
        NSDictionary *info = arr[i];
        CommentsModel *aCmtModel = [[CommentsModel alloc]init];
        aCmtModel.content = [info objectForKey:@"comment"];
        aCmtModel.tid = [info objectForKey:@"tid"];
        aCmtModel.date = [info objectForKey:@"date"];
        aCmtModel.supportCounts = [info objectForKey:@"support"];
        aCmtModel.againstCounts = [info objectForKey:@"against"];
        NSString *name = [info objectForKey:@"name"];
        aCmtModel.name = [name isEqualToString:@""]?@"匿名人士":name;
        
        [modelsArr addObject:aCmtModel];
    }
    
    
    return modelsArr;
}
+(NSString*)stringUpvoteWithCommentID:(NSString*)tid articleID:(NSString*)sid{
    NSString *result = @"http://api.cnbeta.com/capi?";
    //                            app_key=10000&format=json&method=Article.DoCmt&op=against&sid=&tid=0&timestamp=&v=1.0&sign=
    NSString *url = [NSString stringWithFormat:@"app_key=10000&format=json&method=Article.DoCmt&op=support&sid=%@&tid=%@&timestamp=%d&v=1.0&",sid,tid,[self currentTimeStamp]];
    //    NSString *url = [NSString stringWithFormat:@"app_key=10000&articleId=%@&format=json&method=phone.NewsContent2&timestamp=%d&v=1.0&",sid,[self currentTimeStamp]];
    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    NSLog(result);
    return result;
}
+(NSString*)stringDownvoteWithCommentID:(NSString*)tid articleID:(NSString*)sid{
    NSString *result = @"http://api.cnbeta.com/capi?";
    //                                           app_key=10000&format=json&method=Article.DoCmt&op=against&sid=&tid=0&timestamp=&v=1.0&sign=
    NSString *url = [NSString stringWithFormat:@"app_key=10000&format=json&method=Article.DoCmt&op=against&sid=%@&tid=%@&timestamp=%d&v=1.0&",sid,tid,[self currentTimeStamp]];
    //    NSString *url = [NSString stringWithFormat:@"app_key=10000&articleId=%@&format=json&method=phone.NewsContent2&timestamp=%d&v=1.0&",sid,[self currentTimeStamp]];
    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    NSLog(result);
    return result;
}
+(void)commentWithID:(NSString*)tid articleID:(NSString*)sid like:(BOOL)isLike Receiver:(id)targetID selector:(SEL)selector notiName:(NSString*)notiName{
    NSString *url;
    if(isLike){
        url = [self stringUpvoteWithCommentID:tid articleID:sid];
    }
    else{
        url = [self stringDownvoteWithCommentID:tid articleID:sid];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:notiName object:nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


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
@end
