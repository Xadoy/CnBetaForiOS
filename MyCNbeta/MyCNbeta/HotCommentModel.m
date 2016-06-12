//
//  HotCommentModel.m
//  MyCNbeta
//
//  Created by Adoy on 6/12/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "HotCommentModel.h"

@implementation HotCommentModel

+(void)getHotCommentWithReceiver:(id)targetID selector:(SEL)selector{
    
    NSString *url = [self stringForHotCommentList];
    [[NSNotificationCenter defaultCenter]addObserver:targetID selector:selector name:@"hotCommentGetSuccess" object:nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id dic){
             NSLog(@"success --- ");
             [[NSNotificationCenter defaultCenter]postNotificationName:@"hotCommentGetSuccess" object:dic];
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"fail");
             NSLog(@"%@",error);
         }];
    
}
+(NSString*)stringForHotCommentList{
    NSString *result = @"http://api.cnbeta.com/capi?";
                                               //app_key=10000&format=json&method=Article.RecommendComment&timestamp=&v=1.0&sign=
    NSString *url = [NSString stringWithFormat:@"app_key=10000&format=json&method=Article.RecommendComment&timestamp=%d&v=1.0&",[self currentTimeStamp]];
    NSString *temp = @"mpuffgvbvbttn3Rc";
    temp = [self md5:[url stringByAppendingString:temp]];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"sign=%@",temp]];
    result = [result stringByAppendingString:url];
    
    NSLog(result);
    
    return result;
}

+(NSMutableArray*)getCommentModelsWithArray:(NSArray *)arr{
    NSMutableArray *modelsArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for(int i=0;i<arr.count;i++){
        NSDictionary *info = arr[i];
        HotCommentModel *aModel = [[HotCommentModel alloc]init];
        aModel.content = [info objectForKey:@"comment"];
        aModel.articleID = [info objectForKey:@"sid"];
        aModel.cid = [info objectForKey:@"cid"];
        aModel.subject = [info objectForKey:@"subject"];
        [modelsArr addObject:aModel];
    }
    
    
    return modelsArr;
}


@end
