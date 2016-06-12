//
//  HotCommentModel.h
//  MyCNbeta
//
//  Created by Adoy on 6/12/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "NewsModel.h"

@interface HotCommentModel : NewsModel
@property (nonatomic,strong) NSString   *content;
@property (nonatomic,strong) NSString   *subject;
@property (nonatomic,strong) NSString   *cid;

+(void)getHotCommentWithReceiver:(id)targetID selector:(SEL)selector;
+(NSMutableArray*)getCommentModelsWithArray:(NSArray*)arr;
@end
