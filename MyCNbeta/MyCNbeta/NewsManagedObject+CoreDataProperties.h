//
//  NewsManagerdObject+CoreDataProperties.h
//  MyCNbeta
//
//  Created by Adoy on 6/23/16.
//  Copyright © 2016 Adoy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NewsManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsManagedObject(CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *articleID;
@property (nullable, nonatomic, retain) NSString *commentCounts;
@property (nullable, nonatomic, retain) NSNumber *hotCommentRanking;
@property (nullable, nonatomic, retain) NSString *htmlString;
@property (nullable, nonatomic, retain) NSNumber *isViewed;
@property (nullable, nonatomic, retain) NSString *pubtime;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *thumbImgPath;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *viewCounts;

@end

NS_ASSUME_NONNULL_END
