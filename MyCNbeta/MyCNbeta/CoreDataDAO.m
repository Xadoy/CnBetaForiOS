//
//  CoreDataDAO.m
//  MyCNbeta
//
//  Created by Adoy on 6/22/16.
//  Copyright © 2016 Adoy. All rights reserved.
//

#import "CoreDataDAO.h"

@implementation CoreDataDAO
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Core Data 堆栈(I dont know what does that mean....)
//return managedobjectcontext
-(NSManagedObjectContext*)managedObjectContext{
    if(_managedObjectContext){
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator){
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

//return persistentStoreCoordinator
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if(_persistentStoreCoordinator){
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"CoreDataNews.sqlite"];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                              configuration:nil
                                                        URL:storeURL
                                                    options:nil
                                                      error:nil];
    
    return _persistentStoreCoordinator;
    
}

//return managedObjectModel
-(NSManagedObjectModel *)managedObjectModel{
    
    if(_managedObjectModel){
        return  _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataNews" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

-(NSURL*)applicationDocumentsDirectory{
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
