//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Fidan Oruc on 02.09.22.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
