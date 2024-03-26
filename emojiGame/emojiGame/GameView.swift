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
    
    @State private var score: Int = 0
    let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 60, alignment: nil),
        GridItem(.fixed(50), spacing: 60, alignment: nil),
        GridItem(.fixed(50), spacing: 60, alignment: nil),
    ]
    @State private var numOfClicks: Int = 0
    @State private var correctAnswers: Int = 0
    
    @State private var firstCardIndex: Int = -1
    @State private var secondCardIndex: Int = -1
    let correctNumPair: Int = 6
    
    @State private var gameFinished: Bool = false


    
    var body: some View {
        
        NavigationView {
            ZStack{
                //these make the circle designs on the background
                Circle()
                    .foregroundColor(lightPink)
                    .offset(CGSize(width: -90.0, height: -290))
                Circle()
                    .foregroundColor(lightGreen)
                    .offset(CGSize(width: 90.0, height: 320.0))
                VStack{
                    //this text will display score w/ quote interpolation
                    Text("Current Score: \(score)%")
                        .font(.system(size: 25))
                        .padding(.bottom, 470)
                        .bold()
                }
                //this sets the buttons in a grid and creates an indivudal button for every emoji
                LazyVGrid(columns: columns){
                    ForEach(emojis.indices, id: \.self){ i in
                        Button(action: {handleClick(index: i)}, label: {
                            SquareView(emoji: emojis[i], isFlipped: cardsFlipped[i])
                        })
                    }
                }
                HStack{
                    //When the game is finished, the next and retry buttons will appear
                    if gameFinished == true{
                        NavigationLink(destination: FinalPageView().navigationBarBackButtonHidden(true), label: {
                            Text("Next")
                                .font(.system(size: 25))
                                .frame(width: 100, height: 50)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .bold()
                            })
                        Button(action: retry) {
                            Text("Retry")
                                .font(.system(size: 25))
                                .frame(width: 100, height: 50)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .bold()
                        }
                    }
                }
                .padding(.top, 480)
            }
            .onAppear{
                //This will shuffle the emojis' order in array for every new round
                emojis.shuffle()
            }
        }
    }
    
    //this function will handle the clicks
    func handleClick(index: Int){
        //when the bool is true, this means the user clicked on a square so the square goes from blue to clear, the index keeps track which "card" got flipped to check for accuracy
        cardsFlipped[index] = true
        //this accounts for every attempt the user tries
        numOfClicks += 1
        
        //if either button is clicked, it will save the user's choice as the index to be matched w/
        if firstCardIndex == -1 || secondCardIndex == -1{
            if firstCardIndex == -1{
                firstCardIndex = index
                //when this is true, it will appear the emoji behind square
                cardsFlipped[index] = true
            } else {
                //this saves the second card index to match w/ first
                secondCardIndex = index
                cardsFlipped[index] = true
                //if emoji 1 matches w/ emoji 2, it will be saved as one correct anwer and the user's choices reset
                if emojis[firstCardIndex] == emojis[secondCardIndex]{
                    correctAnswers += 1
                    firstCardIndex = -1
                    secondCardIndex = -1
                    
                    //when they get all the correct answers, the score will be calculated and bool turns true, meaning buttons can appear
                    if correctAnswers == correctNumPair{
                        calcScore()
                        gameFinished = true
                    }
                } else{
                    //this allows user to see their choices for a sec before it flips back
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        cardsFlipped[firstCardIndex] = false
                        cardsFlipped[secondCardIndex] = false
                        //this resets the options back to -1 so user can put in new choices
                        self.firstCardIndex = -1
                        self.secondCardIndex = -1
                    }
                }
            }
            
        }
    }
    
    //this calculates the score of user attempt
    func calcScore() {
        if numOfClicks > 0 {
            //gets converted into double for division and then back to int
            score = Int((Double(correctAnswers) / Double(numOfClicks)) * 100)
        } else {
            score = 0
        }
    }

    //this resets everything for user to try again
    func retry() {
        if gameFinished == true{
            score = 0
            emojis.shuffle()
            //every option gets turned into false so the entire grid turns blue again
            for i in cardsFlipped.indices{
                cardsFlipped[i] = false
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
