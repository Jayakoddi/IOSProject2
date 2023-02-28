//
//  NoMoreBoredApp.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-15.
//

import SwiftUI

@main
struct NoMoreBoredApp: App {
    //For saving favourites in core data
    @StateObject var activitiesController = ActivitiesController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, activitiesController.container.viewContext)
        }
    }
}
