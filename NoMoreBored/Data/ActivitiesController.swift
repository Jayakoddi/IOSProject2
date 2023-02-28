//
//  ActivitiesController.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-19.
//

import Foundation
import CoreData

class ActivitiesController :ObservableObject{
    
    let container = NSPersistentContainer(name: "ActivitiesModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save (context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved!!")
        } catch{
            print( "We could not save the data")
        }
    }
    
    
    func addActivity(name: String, context: NSManagedObjectContext){
        let activity = ActivityName(context: context)
        activity.name = name
        
        save( context: context)
    }
    
}
