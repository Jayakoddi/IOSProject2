//
//  OnboardingView.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-15.
//

import SwiftUI

struct OnboardingView: View {
    
    // @AppStorage("onboarding") var isOnboardingActive: Bool = true
    
    var body: some View {
        NavigationView(){
            
            
            ZStack {
                
                VStack (spacing: 20){
                    //:HEADER
                    Spacer()
                    VStack(spacing:0){
                        Text("Are You Bored ?")
                            .font(.system(size: 60))
                            .fontWeight(.heavy)
                            .padding()
                        Text("Boredom is a state of mind, here you will find many cool & fun things to do! ")
                            .font(.title2)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                        
                        
                    }//: End of Header
                    .foregroundColor(.white)
                    .padding(20)
                    //:CENTER
                    ZStack{
                        ZStack{
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 40)
                                .frame(width: 260, height: 260, alignment: .center)
                            
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 80)
                                .frame(width: 260, height: 260, alignment: .center)
                                .padding()
                            
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 80))
                                .foregroundColor(Color.yellow)
                        }//:ZSTACK
                    }//: End of Center section
                    
                    Spacer()
                    
                    //:FOOTER
                    ZStack{
                        //: 1.Background Static
                        Capsule()
                            .foregroundColor(Color.white.opacity(0.2))
                        
                        Capsule()
                            .foregroundColor(Color.white.opacity(0.2))
                            .padding(8)
                        
                        //:2. Call to action
                        Text("Get Started")
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .offset(x: 20)
                        
                        
                        //:3. Capsule-Yellow
                        
                        
                        NavigationLink(destination: HomeView(suggestActivity: Activities(activity: "", type: "", participants: 1, accessibility: 0.1)),
                                       label: {
                            
                            HStack {
                                ZStack{
                                    Circle()
                                        .fill(Color.yellow)
                                    Circle()
                                        .fill(.black.opacity(0.15))
                                        .padding(8)
                                    Image(systemName: "chevron.right.2")
                                        .font(.system(size: 24, weight:.bold))
                                }//: ZSTACK
                                .foregroundColor(.white)
                                .frame(width: 80, height:80, alignment: .center)
                                Spacer()
                                
                            }//:HSTACK
                            
                        })//:Navigation
                        
                    }//: End of Footer
                    .frame(height:80, alignment: .center)
                    .padding()
                    
                }//: VSTACK
                
            }  //:ZSTACK
            .background(Color("ColorBlue"))
            .ignoresSafeArea()
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
