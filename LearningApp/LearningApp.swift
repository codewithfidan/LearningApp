//
//  LearningApp.swift
//  LearningApp
//
//  Created by Fidan Oruc on 25.08.22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
