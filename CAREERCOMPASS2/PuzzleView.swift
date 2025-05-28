//
//  PuzzleView.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 5/5/25.
//

import SwiftUI

struct PuzzleView: View {
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    @State var llblue = Color("llblue")
    
    @StateObject var quizVM = QuizViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    bg_color.ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("vector2")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    }.ignoresSafeArea()
                    VStack(alignment: .center) {
                        Text("Ανακαλύψτε \nτο δυναμικό σας")
                            .font(.largeTitle)
                            .foregroundStyle(dblue)
                            .multilineTextAlignment(.center)
                            .padding(.top, 80)
                        Text("Σχεδιάστηκε για να αναδείξει τις ιδιαίτερες ικανότητες, τα ενδιαφέροντα και τις δυνατότητες του κάθε συμμετέχοντα. \n\n Το κουίζ προσφέρει μια εμπειρία που όχι μόνο δίνει πληροφορίες για επαγγελματικά πεδία, αλλά και ενισχύει τον συνολικό αυτογνωσιακό προσανατολισμό του συμμετέχοντα. \n\nΤο κουίζ αντικατοπτρίζει την πρόκληση και τον ενθουσιασμό για την ανακάλυψη νέων πτυχών του εαυτού και των δυνατοτήτων του.")
                            .foregroundStyle(dblue)
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.bottom, 50)
                        
                        if quizVM.userHasResult {
                            Text("Το αποτέλεσμα του κουίζ σου είναι:")
                                .foregroundStyle(dblue)
                            Text(quizVM.resultDescription())
                                .foregroundStyle(dblue)
                                .font(.title2)
                                .bold()
                        }
                        
                        Rectangle()
                            .frame(maxWidth: 250, maxHeight: 45)
                            .foregroundStyle(dblue)
                            .cornerRadius(10)
                            .overlay {
                                NavigationLink {
                                    QuizView()
                                } label: {
                                    Text("Ξεκίνα εδώ")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .bold()
                                }
                                
                            }
                        Spacer()
                    }
                    .padding(.top, 70)
                }
            }
            .onAppear {
                quizVM.loadUserQuizResult()
                print(quizVM.loadUserQuizResult())
            }
        }
    }
}


#Preview {
    PuzzleView()
}
