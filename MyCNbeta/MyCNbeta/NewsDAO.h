//
//  NewsDAO.h
//  MyCNbeta
//
//  Created by Adoy on 6/23/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "CoreDataDAO.h"
#import "News.h"
#import "NewsManagedObject.h"
@interface NewsDAO : CoreDataDAO



-(NSMutableArray*)findAllNormalNews;
-(NSMutableArray*)findAllHotNews;
-(News*) findById:(NSString*)aid;
-(int) create:(News*)model;
-(int) remove:(News*)model;
-(int) updateHtmlString:(News*)model;
@end
