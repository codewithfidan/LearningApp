//
//  TestView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 03.09.22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        if model.currentQuestion != nil {
           
            VStack{

                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0) ")

                // Question
                CodeTextView()
                // Answers

                // Button
            }.navigationTitle("\(model.currentModule?.category ?? "hello") Test")
        }else{ // we write else option because when we click navigationlink in homeview ti shows us empty view
            
            
            // Test has not loaded yet
            ProgressView()
            //The progress view in SwiftUI is a native view that was introduced in WWDC 2020 and makes it really easy to indicate visually the progress of long-running tasks that take time to complete.
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
