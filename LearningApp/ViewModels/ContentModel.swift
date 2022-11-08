//
//  ContentModel.swift
//  LearningApp
//
//  Created by Fidan Oruc on 25.08.22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

//contols all views and has the data,all of the properties,functions for views - this is going to be observableObject
class ContentModel: ObservableObject{
    
    // Get the reference to the database
    let db = Firestore.firestore()
    
    //List of modules
    @Published var modules = [Module]()
    
    // Current module for ContentView
    @Published var currentModule: Module?
    // keep the state of things like what lesson user is looking at or what question the user currently answering in the quiz Module? -- if the user hasnot selected a module yet,where they see all of the modules
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    
    // Current lesson/question explanation
    @Published var codeTextDescription = NSAttributedString()
    
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    var styleData: Data?
    
    // Current selected content and test - for link in the HomeView and back to the HomeView
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    
    
    init(){
        
        // Parse local style.html
        getLocalStyles()
        
        // Get database modules
        getDatabaseModules()
        
        // getRemoteData()
    }
    
    
    // MARK: - Data methods
    
    func getDatabaseModules(){
         
        // Specify path
        let collection = db.collection("modules")
        
        collection.getDocuments { querySnapshot, error in
            
            
            if error == nil && querySnapshot != nil{
                
                // Create an array for the modules
                var modules = [Module]()
                
                // Loop through the documents and returned
                for doc in querySnapshot!.documents{
                    
                    // Create a new module instance
                    var m = Module()
                    
                    // Parse out the values from the document into the module instance
                    m.id = doc["id"] as? String ?? UUID().uuidString
                    m.category = doc["category"] as? String ?? ""
                    
                    
                    // Parse the lesson content
                    let contentMap = doc["content"] as! [String:Any]
                    m.content.id = contentMap["id"] as? String ?? ""
                    m.content.description = contentMap["description"] as? String ?? ""
                    m.content.image = contentMap["image"] as? String ?? ""
                    m.content.time = contentMap["time"] as? String ?? ""
                    
                    
                    // Parse the test content
                    let testMap = doc["test"] as! [String:Any]
                    m.test.id = testMap["id"] as? String ?? ""
                    m.test.image = testMap["image"] as? String ?? ""
                    m.test.description = testMap["desctiption"] as? String ?? ""
                    m.test.time = testMap["time"] as? String ?? ""
                    
                    
                    // Add it to the modules array
                    modules.append(m)
                }
                
                // Assign our modules to the published property
                DispatchQueue.main.async {
                    self.modules = modules
                }
            }
        }
    }
    
    
    // local json file in the xcode project, if you upload app to the appstore, it is going to part of app bundle and you can not update it without submitting an app update to the app store
    
    // Parse local included json data
    func getLocalStyles(){
        
        /*
        //data.json
        
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
        */
        
        //style.html
        
        // Get a url to the style file
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }catch{
            print("Couldn't parse style file")
        }
        
        
    }
    
    // the best thing having remote json is that you can update json file whenever you want. if you are thinking about changing and updating your data regularly use this way
    
    // Download remote json file and parse data
    func getRemoteData(){
        
        // string path
        let urlString = Constants.dataHostUrl
        
        // create a url object
        let url = URL(string: urlString)
        
        guard url != nil else{
            // could not create url
            return
        }
        
        // Create a URLRequest object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
        //shared is a singleton session object, singleton means it can be only one instance if the session, when the user use your app that's considered a session. there is not going to be more than one session at a time. We can use the URLSession to fire off requests and work with any response such as returned JSONs.
        
        
        let dataTask = session.dataTask(with: request) { data, request, error in
            
            // check if there is an error
            guard error == nil else{
                // there is an error
                return
            }
            // handle the response
            
            do{
                // create json decoder
                let decoder = JSONDecoder()
                
                let moduleData = try decoder.decode([Module].self, from: data!)
                
                
                /* we face this error -  Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
                 because main thread is responsible for updating the ui. it can be busy fetching data in the background
                 */
                DispatchQueue.main.async { // It will assign the code to the main thread to be taken care instead of in a background thread. it basicly assign it to the main thread to take care of when it gets a chance to.
                    
                    // append parsed moduleData to the modules property
                    self.modules += moduleData
                }
                
            }catch{
                // could not parse json
            }
            
        }
        
        
        // kick off the dataTask
        dataTask.resume()
    }
    
    // MARK: - Module navigation methods
    //second way - we are going to keep track of the selected module through the view model which is in our ContentModel
    func beginModule(_ moduleId: String){
        
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
    
    // MARK: - Lesson
    
    func beginLesson(_ lessonIndex: Int){
        
        // Check that the lesson index is within range of module lesson
        if lessonIndex < currentModule!.content.lessons.count{
            currentLessonIndex = lessonIndex
        }else{
            currentLessonIndex = 0
        }
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeTextDescription = addStyling(htmlString: currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        guard currentModule != nil else{
            return false
        }
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
        // it is easier way above
        //return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func nextLesson(){
        
        // Advance the lesson index
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count{
            
            // Set current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeTextDescription = addStyling(htmlString: currentLesson!.explanation)
        }else{
            
            //reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    // MARK: - Question
    
    func beginTest(_ moduleId: String){
        
        // Set the current module
        beginModule(moduleId)
        
        // Set the current question
        currentQuestionIndex = 0
        
        // if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {  // if currentModule is nil, we just assume is 0
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            
            // Set the question content
            codeTextDescription = addStyling(htmlString: currentQuestion?.content ?? "")
        }
    }
    
    func nextQuestion(){
        
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check that it is within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count{
            
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            codeTextDescription = addStyling(htmlString: currentQuestion!.content)
            
        }else{
            // currentQuestionIndex == currentModule!.test.questions.count
            // if not, reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: - Code styling
    
    private func addStyling(htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil{
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        
        // Technique 1  Using valid technique to handle an error --> 'if let x = try? ...'
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        /*
         Technique 2
         
         do{
             if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                 resultString = attributedString
             }
         }catch{
             print("Could not turn html into attributed string")
         }
         */
        
        
        return resultString
    }
}
