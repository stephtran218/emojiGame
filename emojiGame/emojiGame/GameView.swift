//
//  gameView.swift
//  emojiGame
//
//  Created by StudentAM on 3/19/24.
//

import SwiftUI

struct GameView: View {
    
    let lightPink = Color(red: 255/255, green: 192/255, blue: 203/255)
    let lightGreen = Color(red: 172/255, green: 225/255, blue: 175/255 )
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(lightPink)
                .offset(CGSize(width: -90.0, height: -290))
            Circle()
                .foregroundColor(lightGreen)
                .offset(CGSize(width: 90.0, height: 320.0))
        }
    }
}

#Preview {
    GameView()
}
