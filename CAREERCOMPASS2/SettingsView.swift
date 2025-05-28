//
//  SettingsView.swift
//  CAREERCOMPASS
//
//  Created by gregorikouk.dev on 5/5/25.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var bg_color = Color("background")
    @State var dblue = Color("dblue")
    @State var lblue = Color("lblue")
    
    
    var body: some View {
        ZStack {
            ZStack {
                bg_color.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("vector2")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("ΡΥΘΜΙΣΕΙΣ")
                            .foregroundStyle(dblue)
                            .fontWeight(.heavy)
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.bottom, 50)
                
                    Text("Οι ρυθμίσεις μου")
                        .foregroundStyle(dblue)
                        .fontWeight(.medium)
                        .font(.headline)
                    Rectangle()
                        .foregroundStyle(dblue)
                        .frame(maxWidth: .infinity, maxHeight: 1.7)
                    HStack(spacing: 5) {
                        Image("account")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Ρυθμίσεις λογαριασμού")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.vertical)
                    HStack(spacing: 5) {
                        Image("shield")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Κέντρο Απορρήτου")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.bottom)
                    
                  
                    
                    Text("Cookies Center")
                        .foregroundStyle(dblue)
                        .fontWeight(.medium)
                        .font(.headline)
                    Rectangle()
                        .foregroundStyle(dblue)
                        .frame(maxWidth: .infinity, maxHeight: 1.7)
                    HStack(spacing: 5) {
                        Image("stats")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Προβολή προτιμήσεων")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.vertical)
                    HStack(spacing: 5) {
                        Image("trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Εκκαθάριση προτιμήσεων")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.bottom)
                    
                
                    
                    Text("CAREERCOMPASS")
                        .foregroundStyle(dblue)
                        .fontWeight(.medium)
                        .font(.headline)
                    Rectangle()
                        .foregroundStyle(dblue)
                        .frame(maxWidth: .infinity, maxHeight: 1.7)
                    HStack(spacing: 5) {
                        Image("i")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("Όροι και Προϋποθέσεις")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.vertical)
                    HStack(spacing: 5) {
                        Image("repair")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Αναφορά προβλήματος")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.bottom)
                    HStack(spacing: 5) {
                        Image("users")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Προσκάλεσε τους φίλους σου")
                            .foregroundStyle(dblue)
                            .font(.subheadline)
                    }
                    .padding(.bottom)
                    Spacer()
                    Button {
                        viewModel.signOut()
                    } label: {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 45)
                            .foregroundStyle(dblue)
                            .cornerRadius(10)
                            .overlay {
                                Text("Αποσύνδεση")
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                    }
                    .padding(.bottom, 50)

                }
                .padding(.horizontal)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SettingsView()
}
