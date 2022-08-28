//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Fidan Oruc on 26.08.22.
//

import SwiftUI

struct HomeViewRow: View {
    
    //reusable view
    
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            // Using the aspectRatio modifier can help accommodate different screen sizes, since it will scale the view's dimensions in relation to the screen size.
            HStack{
                
                // Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                Spacer()
                
                // Text
                VStack(alignment: .leading, spacing: 10){
                    
                    // Headline
                    Text(title)
                        .bold()
                    
                    // Description
                    Text(description)
                        .font(.caption)
                        .padding(.bottom, 20)
                    
                    // Icons
                    HStack{
                        
                        // Number of lessons/questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        
                        // Time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(Font.system(size: 10))
                    }
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 10)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description", count: "10 Lessons", time: "3 hours")
    }
}
/*
 because we dont have access module in this view that is why
 Image(module.content.image) --> Image(image)
 Text("Learn \(module.category)") --> Text(title)
 Text(module.content.description) --> Text(description)
 Text("\(module.content.lessons.count) lessons") --> Text(count)
 Text(module.content.time) --> Text(time)
 
 
 */
