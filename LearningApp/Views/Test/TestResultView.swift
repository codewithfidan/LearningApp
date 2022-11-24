//
//  TestResultView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 05.09.22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numCorrect: Int
    
    var resultHeading: String {
        if numCorrect > 5{
            return "Awesome!"
        }else if numCorrect > 2 {
            return "Doing great!"
        }else{
            return "Keep learning :("
        }
    }
    var body: some View {
        VStack{
            Spacer()
            Text(resultHeading)
                .bold()
                .font(.title)
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions.")
            Spacer()
            Button {
                
                // send the user back to the HomeView()
                model.currentTestSelected = nil
            } label: {
                ZStack{
                    RectangleCard(color: .orange)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }.padding()
            
        }
    }
}

