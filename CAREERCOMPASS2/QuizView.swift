//
//  QuizView.swift
//  CAREERCOMPASS2
//
//  Created by gregorikouk.dev on 25/5/25.
//


import SwiftUI

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()
    @State private var selectedIndex: Int? = nil
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    @State var llblue = Color("llblue")

    var body: some View {
        if viewModel.showResult {
            QuizResultView(type: viewModel.dominantType())
        } else {
            ZStack {
                ZStack {
                    bg_color.ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("vector2")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    }.ignoresSafeArea()
                }
                VStack(alignment: .leading) {
                    HStack {
                        
                        Text("QUIZ")
                            .foregroundStyle(Color("dblue"))
                            .fontWeight(.heavy)
                            .font(.title2)
                            .padding()
                        Spacer()
                    }
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(llblue)
                            .frame(height: 40)

                        RoundedRectangle(cornerRadius: 20)
                            .fill(dblue)
                            .frame(width: viewModel.progress * UIScreen.main.bounds.width * 0.9, height: 20)
                            .padding(.horizontal)
                            .animation(.easeInOut(duration: 0.5), value: viewModel.progress)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    Text("Ερώτηση \(viewModel.currentIndex + 1)")
                        .font(.title3)
                        .fontWeight(.black)
                        .padding(.horizontal)
                        .foregroundStyle(dblue)
                    
                    Text(viewModel.questions[viewModel.currentIndex].text)
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundStyle(lblue)
                        .bold()
                    
                    ForEach(0..<viewModel.questions[viewModel.currentIndex].options.count, id: \.self) { i in
                        Button(action: {
                            selectedIndex = i
                        }) {
                            HStack {
                                Text(viewModel.questions[viewModel.currentIndex].options[i])
                                    .padding()
                                    .foregroundStyle(dblue)
                                Spacer()
                                if selectedIndex == i {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(dblue)
                                        .padding()
                                }
                            }
                            .background(llblue.opacity(0.5))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            if let index = selectedIndex {
                                viewModel.selectOption(index: index)
                                viewModel.nextQuestion()
                                selectedIndex = nil
                            }
                        } label: {
                            Rectangle()
                                .frame(width: 200, height: 40)
                                .foregroundStyle(.dblue)
                                .cornerRadius(8)
                                .overlay {
                                    Text("Επόμενο")
                                        .foregroundStyle(.white)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                    Spacer()
                }
               
            }
            .navigationBarBackButtonHidden()
        
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(viewModel: QuizViewModel())
    }
}


