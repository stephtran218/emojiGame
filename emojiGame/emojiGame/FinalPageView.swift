//
//  FinalPageView.swift
//  emojiGame
//
//  Created by StudentAM on 3/25/24.
//

import SwiftUI

struct FinalPageView: View {
    let lightPink = Color(red: 255/255, green: 192/255, blue: 203/255)
    let lightGreen = Color(red: 172/255, green: 225/255, blue: 175/255 )
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Circle()
                    .foregroundColor(lightPink)
                    .offset(CGSize(width: -90.0, height: -290))
                Circle()
                    .foregroundColor(lightGreen)
                    .offset(CGSize(width: 90.0, height: 320.0))
                VStack{
                    //this displays emoji
                    Text("😃")
                        .font(.system(size: 150))
                    //this displays great job message
                    Text("Great job!")
                        .font(.title)
                    //this sends them back to gameview to play again
                NavigationLink(destination: GameView().navigationBarBackButtonHidden(true), label: {
                    Text("Play Again")
                        .font(.system(size: 25))
                        .frame(width: 140, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .bold()
                    })
                }
            }
        }
    }
}

#Preview {
    FinalPageView()
}
