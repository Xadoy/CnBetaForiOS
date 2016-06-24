//
//  NewsDAO.m
//  MyCNbeta
//
//  Created by Adoy on 6/23/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "NewsDAO.h"

@implementation NewsDAO


-(NSMutableArray *)findAllNormalNews{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:cxt];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    
//    fetchRequest.fetchLimit = 20;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"articleID" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hotCommentRanking = 200 "];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *reListData = [[NSMutableArray alloc]init];
    //wrong spelling LOL...
    for(NewsManagedObject *mo in listData){
        News *news = [[News alloc] initWithManagedObject:mo];
        [reListData addObject:news];
    }
    
    return reListData;
}
-(NSMutableArray *)findAllHotNews{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:cxt];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    
    //    fetchRequest.fetchLimit = 20;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"articleID" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hotCommentRanking < 100 "];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *reListData = [[NSMutableArray alloc]init];
    //wrong spelling LOL...
    for(NewsManagedObject *mo in listData){
        News *news = [[News alloc] initWithManagedObject:mo];
        [reListData addObject:news];
    }
    
    return reListData;
}
-(News *)findById:(NSString *)aid{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:cxt];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"articleID = %@",aid];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:fetchRequest error:&error];
    
    if([listData count]>0){
        NewsManagedObject *mo = [listData lastObject];
        News *news = [[News alloc]initWithManagedObject:mo];
        return news;
    }
    
    return nil;
}
-(int)create:(News *)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NewsManagedObject *newsObj = [NSEntityDescription insertNewObjectForEntityForName:@"News"
                                                            inManagedObjectContext:cxt];
    newsObj = [NewsDAO managedObject:newsObj FromNewsModel:model];
    
    NSError *error = nil;
    
    if([cxt hasChanges]&&![cxt save:&error]){
        NSLog(@"fail to insert object:%@, %@", error, [error userInfo]);
        return -1;
    }
    
    return 0;
   
}

//Not started yet.
-(int)remove:(News *)model{
    return -1;
}

-(int)updateHtmlString:(News *)model{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:cxt];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.entity = entity;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"articleID = %@",model.articleID];
    fetchRequest.predicate = predicate;
    
    NSError *error =nil;
    NSArray *listData = [cxt executeFetchRequest:fetchRequest error:&error];
    if([listData count]>0){
        NewsManagedObject *news = [listData lastObject];
        news.htmlString = model.htmlString;
        
    }
    error = nil;
    if([cxt hasChanges]&&![cxt save:&error]){
        NSLog(@"fail to modify:%@, %@", error, [error userInfo]);
        return -1;
    }
    return 0;
}

+(NewsManagedObject *)managedObject:(NewsManagedObject*)newsObj FromNewsModel:(News *)obj{
    
    newsObj.articleID = obj.articleID;
    newsObj.commentCounts = obj.commentCounts;
    newsObj.hotCommentRanking = [NSNumber numberWithInteger:obj.hotCommentRanking];
    newsObj.htmlString = obj.htmlString;
    newsObj.isViewed = [NSNumber numberWithBool:obj.isViewed];
    newsObj.pubtime = obj.pubTime;
    newsObj.summary = obj.summary;
    newsObj.thumbImgPath = obj.thumbImgUrlString;
    newsObj.title = obj.title;
    newsObj.viewCounts = obj.viewCounts;
    
    return newsObj;
}
@end
