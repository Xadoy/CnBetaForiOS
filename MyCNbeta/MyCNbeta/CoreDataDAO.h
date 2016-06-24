//
//  CoreDataDAO.h
//  MyCNbeta
//
//  Created by Adoy on 6/22/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataDAO : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

-(NSURL*)applicationDocumentsDirectory;

@end
