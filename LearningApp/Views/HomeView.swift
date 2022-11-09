//
//  HomeView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 25.08.22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                Text("What do you want to do today?")
                    .padding(.leading)
                
                ScrollView{
                    
                    LazyVStack{
                        
                        ForEach(model.modules){ module in
                            
                            VStack(){
                                //You can add tags and selection parameters to your NavigationLink to track what navigation the user is on.
                                NavigationLink(tag: module.id.hash, selection: $model.currentContentSelected) {
                                    ContentView()
                                        .onAppear {
                                            model.getLessons(module: module) {
                                                model.beginModule(module.id)
                                            }
                                        }
//                                    .onDisappear(perform: {
//                                        model.currentModule = nil
//                                    })
                                } label: {
                                    //Learning card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                // we have the same tag: module.id but the difference is that we are going to use a different property to track test vs content
                                NavigationLink(tag: module.id.hash, selection: $model.currentTestSelected) {
                                    TestView()
                                        .onAppear {
                                            model.getQuestions(module: module) {
                                                model.beginTest(module.id)
                                            }
                                        }
                                } label: {
                                    // Test card
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                                }
                                // ios  14.5 bug -  if you have more than one navigationlink on the same view
                                NavigationLink(destination: EmptyView()) {
                                    EmptyView()
                                }
                            }.padding(.bottom, 5)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
            }.navigationBarTitle("Get Started")
                .onChange(of: model.currentContentSelected) { changedValue in
                    if changedValue == nil{
                        model.currentModule = nil
                    }
                }
                .onChange(of: model.currentTestSelected) { changedValue in
                    if changedValue == nil{
                        model.currentModule = nil
                        
                    }
                }
        }.navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
