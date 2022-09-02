//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 28.08.22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        //We used GitHub pages to host our information, but you can use your own server and get a URL that way as well.
        
        VStack{
            // Only show video if we get a valid url
            if url != nil {
                //To add a VideoPlayer view, you need to import AVKit first.
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            
            CodeTextView()
            
            // Show next lesson button, only if there is a next lesson button
            if model.hasNextLesson(){
                Button {
                    // Advance the lesson
                    model.nextLesson()
                } label: {
                    
                    ZStack{
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Next lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
