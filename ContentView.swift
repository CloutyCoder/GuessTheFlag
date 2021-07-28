//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Nseka Bimwela on 7/12/21.
//

import SwiftUI



struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var message = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...5)
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.red, .black, .blue, .purple, .red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            // Instructions
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the Flag of")
                        .foregroundColor(.white)
                        
                    Text(countries[correctAnswer])
                        .title()
                }
                
                  ForEach(0..<5) {number in
                    Button(action: {
                        flagTapped(number)
                        checkScore(number)
                        theAnswer(number)
                    })
                        {
                        Image(countries[number])
                            .renderingMode(.original)
                            .flagImage()
                    }
                }
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle),
                      message: Text("\(message)"),
                      dismissButton: .default(Text("Continue")) {
                        askQuestion()
                      })
            }
            
            // Score
            VStack {
                Spacer()
                Text("\(userScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width: 100, height: 40)
                    .border(Color.white, width: 4 )
                    .shadow(color: .black, radius: 2)
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func theAnswer(_ number: Int) {
        if number == correctAnswer {
            message = "This is the flag of \(countries[correctAnswer])."
        } else {
            message = "I didnt say that one, I said \(countries[correctAnswer])"
        }
    }
    
    func checkScore(_ number: Int) -> Int {
        if number == correctAnswer {
            userScore += 1
        } else {
            userScore += 0
        }
        return userScore
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...4)
    }
}
struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
    }
}
extension View {
    func flagImage() -> some View {
        return self.modifier(FlagImage())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.largeTitle.weight(.black))
            .foregroundColor(Color.arcticBlue)
    }
}

extension Color {
    static let arcticBlue = Color(red: 30/255, green: 150/255, blue: 255/255)
}
extension View {
    func title() -> some View {
        return self.modifier(Title())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
