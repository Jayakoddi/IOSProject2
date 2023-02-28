//
//  Favourites.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-15.
//

import SwiftUI

struct Favourites: View {
    
    @EnvironmentObject var favourites : FavouriteManager
    
    //Read from Core data
    @Environment(\.managedObjectContext) var manageObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var activity: FetchedResults<ActivityName>
    
    var body: some View {
        ZStack{
            
            VStack(spacing:0){
                Spacer()
                    .frame(height:20)
                HStack{
                    Text("My Favourites")
                        .font(.system(size: 40))
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .padding()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 40))
                }
                
                //Display favourites 
                List{
                    ForEach(activity) { item in
                        HStack{
                            Text(item.name!)
                                .font(Font.system(.title3, design: .rounded).weight(.semibold))
                            
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            
                        }
                    }
                    .onDelete(perform: deleteActivity)
                }//: List
                .background(.linearGradient(Gradient(colors: [Color("ColorBlue").opacity(0.7),Color.white]),
                                            startPoint: .top, endPoint: .bottom))
                
                .scrollContentBackground(.hidden)
                
                
            }//:VSTACK
            
            
        }//:ZSTACK
        .background(.linearGradient(Gradient(colors: [Color("ColorBlue").opacity(0.7),Color.white]),
                                    startPoint: .top, endPoint: .bottom))
        
    }
    
    // Delete from the favoutites
    private func deleteActivity(offsets: IndexSet)
    {
        withAnimation{
            offsets.map{activity[$0]}.forEach(manageObjContext.delete)
            ActivitiesController().save(context: manageObjContext)
            
        }
    }
}

struct Favourites_Previews: PreviewProvider {
    static var previews: some View {
        Favourites()
            .environmentObject(FavouriteManager())
    }
}

