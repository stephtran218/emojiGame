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
    
    var body: some View {
        NavigationView {
            ZStack{
                Circle()
                    .foregroundColor(lightPink)
                    .offset(CGSize(width: -90.0, height: -290))
                Circle()
                    .foregroundColor(lightGreen)
                    .offset(CGSize(width: 90.0, height: 320.0))
                VStack{
                    Text("Current Score: \(score)%")
                        .font(.system(size: 25))
                        .padding(.bottom, 470)
                        .bold()
                }
                LazyVGrid(columns: columns){
                    ForEach(emojis.indices, id: \.self){ i in
                        Button(action: {handleClick(index: i)}, label: {
                            SquareView(emoji: emojis[i], isFlipped: cardsFlipped[i])
                        })
                    }
                }
                HStack{
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
        numOfClicks += 1
        
        if firstCardIndex == -1 || secondCardIndex == -1{
            if firstCardIndex == -1{
                firstCardIndex = index
                cardsFlipped[index] = true
            } else {
                secondCardIndex = index
                cardsFlipped[index] = true
                if emojis[firstCardIndex] == emojis[secondCardIndex]{
                    correctAnswers += 1
                    firstCardIndex = -1
                    secondCardIndex = -1
                    
                    if correctAnswers == correctNumPair{
                        calcScore()
                    }
                } else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        cardsFlipped[firstCardIndex] = false
                        cardsFlipped[secondCardIndex] = false
                        
                        self.firstCardIndex = -1
                        self.secondCardIndex = -1
                    }
                }
            }
            
        }
    }
    
    func calcScore() {
        if numOfClicks > 0 {
            score = (correctAnswers * 100) / numOfClicks
        } else {
            score = 0
        }
    }

    
    func retry() {
        score = 0
        emojis.shuffle() // Shuffle emojis for a new game
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
