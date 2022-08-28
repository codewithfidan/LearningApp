//
//  ContentView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 26.08.22.
//

import SwiftUI

struct ContentView: View {
    
    // we are looping through all of the lessons in the module and if i include evironment object in here - in the module i only have a list of modules @Published var modules = [Module]() and i dont know which module user select. one way - i could handle this create module property --> var module: Module and i can count on in the homeview passing the selected module through to the contentview. but when i go down to the lesson level and i want to let the user switch from lesson one from lesson two without drilling back up to the lesson list i started getting a swiftui errors. some sort of inconsistencies with the view hierarchy as i was just trying to swap lessons ,so instead of passing through the module we have second way
    
    //second way - we are going to keep track of the selected module through the view model which is in our ContentModel
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        ScrollView{
            
            LazyVStack{
                
                // confirm that currentModule is set
                if model.currentModule != nil{
                    
                    ForEach(0..<model.currentModule!.content.lessons.count, id: \.self){ index in
                        
                       ContentViewRow(index: index)
                    }
                }
            }.padding()
                .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
