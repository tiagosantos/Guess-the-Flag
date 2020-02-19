//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Carlos Tiago on 18/02/20.
//  Copyright © 2020 Carlos Tiago. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreAnswer = ""
    @State private var scoreUser = [0,0] //0 = wrong and 1 = correct

    
    var body: some View {
         ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                     .foregroundColor(.white)
                    Text(countries[correctAnswer])
                     .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                       self.flagTapped(number)

                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                VStack {
                        Text("Correct: \(scoreUser[1]). Wrong: \(scoreUser[0])")
                         .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message:
                Text(scoreAnswer), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreAnswer = "That’s the flag of \(countries[correctAnswer])."
            scoreUser[1] += 1
        } else {
            scoreTitle = "Wrong!"
            scoreAnswer = "You select a flag of \(countries[number])."
            scoreUser[0] += 1
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
