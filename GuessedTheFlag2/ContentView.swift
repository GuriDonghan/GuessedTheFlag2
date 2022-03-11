//
//  ContentView.swift
//  GussedTheFlag2
//
//  Created by USER on 2022/03/11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var questionCount = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var countGame = 0
    
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("셰계 국기를 맞춰보자!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                
                VStack(spacing: 15) {
                    VStack {
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                        Text("국기를 맞춰 보세요!")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                            //                                .clipShape(Capsule())
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
                
                
                Text("점수: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("확인", action: askQuestion)
        } message: {
            Text("현재 점수는 \(userScore)")
        }
        
        .alert("게임종료!", isPresented: $questionCount) {
            Button("다시 하기", action: reset )
        } message: {
            Text("선우의 최종 점수는 \(userScore)점")
        }

    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "정답입니다!"
            userScore += 5
        } else {
            scoreTitle = "앗! 이건 \(countries[number]) 국기입니다."
            userScore -= 2
        }
        
        showingScore = true
        
        // 게임 횟수를 제한 하는 Code
        countGame += 1
        //        print(countGame)
        if countGame >= 8 {
            questionCount = true
        } else {
            questionCount = false
        }
        //        print(questionCount)
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        countries.shuffle()
        countGame = 0
        userScore = 0
        showingScore = false

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

