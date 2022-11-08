//
//  LearningApp.swift
//  LearningApp
//
//  Created by Fidan Oruc on 25.08.22.
//

import SwiftUI
import FirebaseCore

@main
struct LearningApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
