//
//  Profile.swift
//  LearningApp
//
//  Created by Fidan Oruc on 19.11.22.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        Button {
            
            // Sign out the user
            try! Auth.auth().signOut()
            model.checkLogin()
            
        } label: {
            ZStack{
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height:40)
                    .cornerRadius(10)
                
                Text("Sign Out!")
                    .foregroundColor(.white)
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
