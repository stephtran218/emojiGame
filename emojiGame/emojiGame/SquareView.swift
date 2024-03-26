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
            //using ternary operator so square turns clear when user clicks it to reveal emoji
                .foregroundColor(isFlipped ? Color.clear : Color.blue)
            //when isFlipped is true, the emoji will be displyed behind it
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
