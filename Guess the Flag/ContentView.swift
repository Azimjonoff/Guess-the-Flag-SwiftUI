//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Azimjonoff on 09/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var chosenAnswer = 0
    @State private var attemptNumber = 0
    @State private var message = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button() {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(5)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if attemptNumber == 8 {
                Button("New Game", action: askQuestion)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            Text(message)
        }
    }
    
    func flagTapped(_ number: Int) {
        chosenAnswer = number
        attemptNumber += 1
        if attemptNumber == 8 {
            scoreTitle = "❗️Game over❗️"
            if number == correctAnswer {
                score += 1
            }
            message = "Your Score: \(score)"
            attemptNumber = 0
            score = 0
        } else if number == correctAnswer {
            scoreTitle = "✅Correct✅"
            message = "You found the correct flag"
            score += 1
        } else {
            scoreTitle = "❌Incorrect❌"
            message = "You chose the flag of \(countries[chosenAnswer])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
