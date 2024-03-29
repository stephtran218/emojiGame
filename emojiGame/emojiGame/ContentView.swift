//
//  ContentView.swift
//  emojiGame
//
//  Created by StudentAM on 3/15/24.
//

import SwiftUI

struct ContentView: View {
    
@State private var pickOne: Int = -1
@State private var pickTwo: Int = -1
@State private var score: Int = 0
@State private var gameFinished: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //this makes sure the wallpaper reaches the entire egde of screen
                Image("emojiCover")
                    .ignoresSafeArea()
                VStack {
                    Text("EmojiMatch")
                        .foregroundColor(.white)
                        .font(.system(size: 52))
                        .frame(width: 300, height: 115)
                        .background(Color.orange)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 50)
                        .padding(.bottom, 290)
                    
                    //this sends user to game view page for game to start when button clicks
                    NavigationLink(destination: GameView().navigationBarBackButtonHidden(true), label: {
                        Text("Start")
                            .foregroundColor(.white)
                            .font(.system(size: 35))
                            .frame(width: 120, height: 70)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding([.leading, .trailing], 20)
                    })

                }
            }
        }

    }
}

func startGame(){
    
}
struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
