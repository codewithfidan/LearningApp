//
//  TestView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 03.09.22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectetAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        
        if model.currentQuestion != nil {
           
            VStack(alignment: .leading){

                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0) ")
                    .padding(.leading, 20)
                // Question
                CodeTextView().padding(.horizontal,20)
                
                // Answers
                ScrollView{
                    
                    VStack{
                        // write ! because we check in here model.currentQuestion != nil that is why we safely unwrap currentQuestion!
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self){ index in
                            
                            Button {
                              // Track the selected index
                                selectetAnswerIndex = index
                            } label: {
                                ZStack{
                                    
                                    if submitted == false{
                                        RectangleCard(color: index == selectetAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    }else{
                                        
                                        // Answer has been submitted
                                        if index == selectetAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex{
                                            // User has selected the right answer
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }else if index == selectetAnswerIndex &&
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
                
                
                
                // Submit Button
                
                Button {
                    
                    // change submitted state to true
                    submitted = true
                    
                    // Check the answer and increment the counter if correct
                    if selectetAnswerIndex == model.currentQuestion!.correctIndex{
                        numCorrect += 1
                    }
                    
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Submit")
                            .bold()
                            .foregroundColor(.white)
                    }
                }.disabled(selectetAnswerIndex == nil) // if we dont choose any answer, we cant click submit button
                .padding()

                
                
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
