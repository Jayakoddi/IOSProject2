//
//  sheetView.swift
//  NoMoreBored
//
//  Created by Christy Dinakaran on 2022-12-16.
//

import SwiftUI

struct sheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var type:String
    
    //: Choose a category to display an activity from that category
    
    
    var types = ["Education", "Recreational", "Social","Diy", "Charity", "Cooking", "Relaxation", "Music", "Busy Work", "All"]
    
    
    var body: some View {
        VStack{
            
            
            HStack{
                Image(systemName: "timelapse")
                Text("Pick a Category")
                    .font(.title3)
            }
            .fontWeight(.bold)
            
            Picker("Please choose a category",selection: $type) {
                ForEach(types, id: \.self) { type in
                    Text(type)
                }
            }.pickerStyle(WheelPickerStyle())
            
            Button(action: {
                
                dismiss()
            }, label: {
                HStack {
                    Spacer()
                    Text("Apply")
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width:350, height: 50)
                        .background(Color.blue)
                        .cornerRadius(20)
                    Spacer()
                }
            })
        }}
}

struct sheetView_Previews: PreviewProvider {
    static var previews: some View {
        sheetView(type: .constant("All"))
    }
}
