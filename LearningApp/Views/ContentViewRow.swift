//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Fidan Oruc on 26.08.22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        
        // Lesson card
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            HStack(spacing: 30){
                Text(String(index + 1))
                    .bold()
                    .font(.title3)
                   
                
                VStack(alignment: .leading,spacing: 5){
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }.padding()
        }.padding(.bottom, 5)
            .accentColor(.black)
        
    }
}
