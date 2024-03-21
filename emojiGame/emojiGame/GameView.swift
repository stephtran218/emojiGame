//
//  gameView.swift
//  emojiGame
//
//  Created by StudentAM on 3/19/24.
//

import SwiftUI

struct GameView: View {
    
    @State var cardsFlipped: [Bool] = Array(repeating: false, count: 16)
    @State var emojis = ["😀", "😀" ,"😁", "😁", "😂", "😂", "🤣", "🤣", "😃", "😃", "😄", "😄",]
    let lightPink = Color(red: 255/255, green: 192/255, blue: 203/255)
    let lightGreen = Color(red: 172/255, green: 225/255, blue: 175/255 )
    var score: Int = 0
    let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 60, alignment: nil),
        GridItem(.fixed(50), spacing: 60, alignment: nil),
        GridItem(.fixed(50), spacing: 60, alignment: nil),

    ]
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(lightPink)
                .offset(CGSize(width: -90.0, height: -290))
            Circle()
                .foregroundColor(lightGreen)
                .offset(CGSize(width: 90.0, height: 320.0))
            VStack{
                Text("Current Score: \(score)")
                    .font(.system(size: 25))
                    .padding(.bottom, 470)
            }
            LazyVGrid(columns: columns){
                ForEach(emojis.indices, id: \.self){ i in
                    Button(action: {handleClick(index: i)}, label: {
                        SquareView(emoji: emojis[i], isFlipped: cardsFlipped[i])
                    })
                }
                
            }
            
        }
        
    }
    func handleClick(index: Int){
        cardsFlipped[index] = true
    }
}



#Preview {
    GameView()
}
