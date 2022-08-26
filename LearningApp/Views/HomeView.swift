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
                                //Learning card
                                HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                
                                // Test card
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Get Started")
        }.navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
