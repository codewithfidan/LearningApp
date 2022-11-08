//
//  TestView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 03.09.22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    @State var showResults = false
    
    var buttonText: String{
        if submitted == true{
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                //this is the last question
                return "Finish"
            }else{
                return "Next"
            }
            
        }else{
            return "Submit"
        }
    }
    
    var body: some View {
        
        
        if model.currentQuestion != nil && showResults ==  false {
            
            VStack(alignment: .leading){
                
                // MARK: - Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0) ")
                    .padding(.leading, 20)
                // Question
                CodeTextView().padding(.horizontal,20)
                
                // MARK: - Answers
                ScrollView{
                    
                    VStack{
                        // write ! because we check in here model.currentQuestion != nil that is why we safely unwrap currentQuestion!
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self){ index in
                            
                            Button {
                                // Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack{
                                    
                                    if submitted == false{
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    }else{
                                        
                                        // Answer has been submitted
                                        if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex{
                                            // User has selected the right answer
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            // User has selected the wrong answer
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                        }else if index == model.currentQuestion!.correctIndex {
                                            // if the user select wrong answer show wrong and right answer at the same time
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }else{
                                            RectangleCard().frame(height: 48)
                                        }
                                        
                                    }
                                    
                                    
                                    Text(model.currentQuestion!.answers[index])
                                        .foregroundColor(.black)
                                }
                            }.disabled(submitted) // if submitted is true it is going to disabled
                            
                            
                            
                            
                        }
                    }.padding()
                }
                
                
                
                // MARK: - Submit Button
                
                Button {
                    // 2. when submitted == true comes here second
                    
                    // Check if answer has been submitted
                    if submitted == true{
                        
                        // check if it is the last question
                        if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                            showResults = true
                        }else{
                            
                            // Answer has already been submitted, move to next question
                            model.nextQuestion()
                            
                            // Reset properties - this is going to allow the user again to select a new answer for the next question.
                            submitted = false
                            selectedAnswerIndex = nil
                        }
                        
                    }else{
                        // 1. when button tapped it comes here first
                        // Submit the answer
                        
                        // change submitted state to true
                        submitted = true
                        
                        // Check the answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex{
                            numCorrect += 1
                        }
                    }
                    
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                    }
                }.disabled(selectedAnswerIndex == nil) // if we dont choose any answer, we cant click submit button
                    .padding()
                
                
                
            }.navigationTitle("\(model.currentModule?.category ?? "hello") Test")
        }
        else if showResults == true{
            
            /* if currentQuestion = nil, show the TestResultView.
             now currentQuestion = nil, because we write in the nextQuestion()
             
              //currentQuestionIndex == currentModule!.test.questions.count
              //if not, reset the properties
             currentQuestionIndex = 0
             currentQuestion = nil
            */
            
            
            TestResultView(numCorrect: numCorrect)
            // we write else option because when we click navigationlink in homeview ti shows us empty view
            
            
            // Test has not loaded yet
            //ProgressView()
            //The progress view in SwiftUI is a native view that was introduced in WWDC 2020 and makes it really easy to indicate visually the progress of long-running tasks that take time to complete.
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
