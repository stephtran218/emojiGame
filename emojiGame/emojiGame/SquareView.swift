//
//  SquareView.swift
//  emojiGame
//
//  Created by StudentAM on 3/21/24.
//

import SwiftUI

struct SquareView: View {
    var emoji: String
    var isFlipped: Bool
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 80, height: 80)
                .foregroundColor(isFlipped ? Color.clear : Color.blue)
            if isFlipped{
                Text("\(emoji)")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    SquareView(emoji: "😀", isFlipped: false)
}
