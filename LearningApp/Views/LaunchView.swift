//
//  LaunchView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 19.11.22.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.loggedIn == false{
            
            // Show login view
            LoginView()
                .onAppear {
                    // Check if the user is logged in or not
                    model.checkLogin()
                }
        }else{
            
            // Show the logged in view
            TabView{
                HomeView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Learn")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .onAppear {
                model.getDatabaseModules()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
