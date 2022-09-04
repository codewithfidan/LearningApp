//
//  CodeTextView.swift
//  LearningApp
//
//  Created by Fidan Oruc on 28.08.22.
//

import SwiftUI

struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
   
    
    //makeUIView creates the initial view object and
    func makeUIView(context: Context) -> UITextView {
     
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }
    
    //updateUIView will update the state of the view
    func updateUIView(_ textView: UIViewType, context: Context) {
        
        // Set the attribudet text for the lesson
        textView.attributedText = model.codeTextDescription
        
        // Scroll back to the top
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
