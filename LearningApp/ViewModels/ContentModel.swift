//
//  ContentModel.swift
//  LearningApp
//
//  Created by Fidan Oruc on 25.08.22.
//

import Foundation
import SwiftUI

//contols all views and has the data,all of the properties,functions for views - this is going to be observableObject
class ContentModel: ObservableObject{
    
    
    //List of modules
    @Published var modules = [Module]()
    
    // Current module for ContentView
    @Published var currentModule: Module?
    // keep the state of things like what lesson user is looking at or what question the user currently answering in the quiz Module? -- if the user hasnot selected a module yet,where they see all of the modules
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init(){
        
        getLocalData()
    }
    
    
    // MARK: - Data methods
    func getLocalData(){
        
        
//MARK: data.json
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        do{
            // Read the file into a data object
            let jsondata = try Data(contentsOf: jsonUrl!)
            
            // Decode the json into an array of modules
            let jsondecoder = JSONDecoder()
            
            let moduleData = try jsondecoder.decode([Module].self, from: jsondata)
            //when you pass a type into method or initializer method you specify self to pass that as a parameter pass to type
            
            // Assign parsed moduleData to modules property
            self.modules = moduleData
            
            
        }catch{
            //to do log
            print("Couldn't parse json file")
        }
//MARK: style.html
        
        // Get a url to the style file
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }catch{
            print("Couldn't parse style file")
        }
        
        
    }
    
    // MARK: - Module navigation methods
    //second way - we are going to keep track of the selected module through the view model which is in our ContentModel
    func beginModule(_ moduleId: Int){
        
        // Find the index for this module id
        for index in 0..<modules.count{
            
            if modules[index].id == moduleId{
                
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        
        // Set the currenbt module
        currentModule = modules[currentModuleIndex]
    }
    
    
}
