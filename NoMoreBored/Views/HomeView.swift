//
//  HomeView.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-15.
//

import SwiftUI

struct HomeView: View {
    
    
    @StateObject var favourites = FavouriteManager()
    
    //Core data
    @Environment(\.managedObjectContext) var managedObjContext
    
    @State private var showingAlert = false
    @State  var type = "All" // radon category
    @State private var showingSheet = false
    
    
    @State var backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color("ColorBlue"), Color.white.opacity(0.7)]),
        startPoint: .top, endPoint: .bottom)
    
    @State var suggestActivity: Activities
    
    var body: some View {
        
        
        ZStack{
            backgroundGradient
            VStack(spacing: 10) {
                Spacer()
                Text("Activity Suggestion!")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.top, 35)
                
                
                Text(suggestActivity.activity)
                
                    .font(.custom("Georgia", fixedSize: 28))
                    .italic()
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                    .frame(width: 380, height:130)
                    .multilineTextAlignment(.center)
                
                
                
                
                ZStack{
                    Circle()
                        .stroke(.white.opacity(0.2), lineWidth: 40)
                        .frame(width: 260, height: 260, alignment: .center)
                    
                    Circle()
                        .stroke(.white.opacity(0.2), lineWidth: 80)
                        .frame(width: 260, height: 260, alignment: .center)
                        .padding()
                    
                    
                    //: Description
                    VStack(alignment: .leading, spacing: 30){
                        
                        
                        
                        HStack(spacing:20){
                            Image(systemName: "square.grid.3x3.middleright.filled")
                                .font(.system(size: 40))
                            VStack(alignment:.leading){
                                Text("Accessability")
                                Text(String(suggestActivity.accessibility)+"%")
                                    .font(.title3)
                            }
                        }//: HSTACK
                        
                        HStack(spacing:20){
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 40))
                            VStack(alignment:.leading){
                                Text("Participants")
                                Text(String(suggestActivity.participants))
                                    .font(.title3)
                            }
                        }//: HSTACK
                        
                        HStack(spacing:20){
                            Image(systemName: "timelapse")
                                .renderingMode(.original)
                                .font(.system(size: 40))
                            
                            VStack(alignment:.leading){
                                Text("Type")
                                Text(suggestActivity.type.uppercased())
                                    .font(.title3)
                            }
                        }//: HSTACK
                        
                    }//:VSTACK
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                }
                .padding()
                
                // Footer
                Text("Not Happy!")
                    .font(.system(size: 20))
                //.foregroundColor(.white)
                    .fontWeight(.semibold)
                //Button
                ZStack{
                    
                    Capsule()
                        .foregroundColor((Color.white).opacity(0.3))
                    
                    Capsule()
                        .foregroundColor(Color("ColorBlue").opacity(0.5))
                        .padding(8)
                    
                    //: Call to action
                    Text("Try Another One!")
                        .fontWeight(.semibold)
                }//ZSTACK
                .frame(width: 180, height:50, alignment: .center)
                .onTapGesture {
                    Task{await loaddata()
                    }
                }
                
                HStack(spacing: 20){
                    Button{
                        showingSheet = true
                    }label:{
                        Image(systemName: "timelapse")
                            .foregroundColor(Color("ColorBlue"))
                    }
                    .sheet(isPresented: $showingSheet){
                        sheetView(type: self.$type)
                        
                    }
                    
                    NavigationLink(destination:Favourites() .environmentObject(favourites), label: {
                        Image(systemName: "heart.circle")
                            .foregroundColor(.red)
                    })
                    
                    Button{
                        showingAlert = true
                        //favourites.addToFavourites(name: suggestActivity.activity)
                        ActivitiesController().addActivity(name: suggestActivity.activity, context: managedObjContext)
                        
                    }label: {
                        Image(systemName: "goforward.plus")
                            .foregroundColor(Color("ColorBlue"))
                        
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Added"), message: Text("Activity is added to your Favourites!"), dismissButton: .default(Text("Got it!")))
                    }
                }
                .font(.system(size: 50))
                
                Spacer()
                
            }//:VSTACK
            
            
            
        }
        
        .ignoresSafeArea()
        .task {
            await loaddata()
        }
        .navigationBarHidden(true)
    }
    
    //: Load Data from Bored API
    func loaddata () async {
        var address = ""
        
        if (type == "All")
        {address = "https://www.boredapi.com/api/activity"
            
        }else
        {
            type = type.lowercased()
            type = type.filter {!$0.isWhitespace}
            address = "https://www.boredapi.com/api/activity?type=\(type)"
        }
        changeBankground()
        guard let url = URL(string: address )else {
            print("Invalid URL")
            return
        }
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Activities.self, from: data) {
                suggestActivity = decodedResponse
                
            }
        } catch {
            print("Invalid data")
        }
    }
    //Change background color based on the Type of activity chosen
    func changeBankground(){
        
        if (type == "music" || type == "social"){
            backgroundGradient = LinearGradient(
                gradient: Gradient(colors: [Color("ColorRed"), Color.white.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom)
        }else if (type == "relaxation" || type == "education"){
            backgroundGradient = LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.white.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom)
            
        }else if (type == "recreational"){
            backgroundGradient = LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.white.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom)
            
        }else if (type == "cooking" || type == "diy"){
            backgroundGradient = LinearGradient(
                gradient: Gradient(colors: [Color.teal, Color.white.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom)
            
        }else if (type == "busywork"){
            backgroundGradient = LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.black.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom)
            
        }else if (type == "All"){
            backgroundGradient = LinearGradient(
                gradient: Gradient(colors: [Color("ColorBlue"), Color.white.opacity(0.7)]),
                startPoint: .top, endPoint: .bottom)
            
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(suggestActivity: Activities(activity: "", type: "", participants: 0, accessibility: 0.1))
    }
}
