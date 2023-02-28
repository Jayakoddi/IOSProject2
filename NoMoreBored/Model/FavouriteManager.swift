//
//  FavouriteManager.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-15.
//

import Foundation

class FavouriteManager: ObservableObject {
    
    @Published var myFavourites :[String] = []
    
    var itemIsThere = false //is item in the list
    
    func addToFavourites(name : String){
        
        //if the activity is not already in the favourites then  add
        if let index = myFavourites.firstIndex(of: name){
            //do nothing
        }else{
            myFavourites.append(name)
        }
        
    }//: END of add FUNCTION
    
    func removeFromFavourites(name: String){
        myFavourites = myFavourites.filter{$0 != name}
    }//: END of remove FUNCTION
    
}
