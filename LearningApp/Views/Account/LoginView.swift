//
//  LoginView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 19.11.22.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import Firebase

struct LoginView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var loginMode = Constants.LoginMode.login // default tab must be login
    
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var errorMessage: String?
    
    var buttonText: String{
        if loginMode == Constants.LoginMode.login{
            return "Login"
        }else{
            return "Sign Up"
        }
    }
    
    var body: some View {
        
        VStack(spacing: 10){
            Spacer()
            // Logo title
            Image(systemName: "book")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 130)
            Text("Learn")
                .bold()
            Spacer()
            // Picker
            Picker(selection: $loginMode) {
                
                Text("Log In")
                    .tag(Constants.LoginMode.login)
                    
                
                Text("Sign Up")
                    .tag(Constants.LoginMode.createAccount)
                
            } label: {
                
            }.pickerStyle(.segmented)
                

            // Form
            Group{
                TextField("Email", text: $email)
                
                if loginMode == Constants.LoginMode.createAccount{
                    TextField("Name", text: $name)
                }
                
                SecureField("Password", text: $password)
                
                if errorMessage != nil{
                    Text(errorMessage!)
                        .foregroundColor(.red)
                        .font(.callout)
                }
            }
            
            // Button
            Button {
                if loginMode == Constants.LoginMode.login{
                    
                    // Log the user in
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        
                        // Check for the errors
                        guard error == nil else{
                            errorMessage = error!.localizedDescription
                            return
                        }
                        // Clear errorMessage
                        self.errorMessage = nil
                        
                        // Fetch the user meta data
                        self.model.getUserData()
                        // Change the view to logged in view
                        self.model.checkLogin()
                    }
                }else{
                    // Create a new account
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        
                        guard error == nil else{
                            errorMessage = error!.localizedDescription
                            return
                        }
                        // Clear error message
                        self.errorMessage = nil
                        
                        // Save first name
                        let firebaseUser = Auth.auth().currentUser
                        let db = Firestore.firestore()
                        let ref = db.collection("users").document(firebaseUser!.uid)
                        
                        ref.setData(["name":name], merge: true)
                        
                        // Update the user meta data
                        var user = UserService.shared.user
                        user.name = name
                        
                        // Change the view to logged in view
                        self.model.checkLogin()
                    }
                }
                
            } label: {
                ZStack{
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height:40)
                        .cornerRadius(10)
                    
                    Text(buttonText)
                        .foregroundColor(.white)
                }
            }
            Spacer()
            
        }
        .padding(.horizontal, 40)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
